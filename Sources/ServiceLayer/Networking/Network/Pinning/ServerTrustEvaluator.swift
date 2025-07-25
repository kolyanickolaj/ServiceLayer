import Foundation
import Security

// Heavily inspired by https://github.com/datatheorem/TrustKit 🙏

/// Implement HTTP Key Pinning (HPKP) validation, based on RFC 7469 (not strict):
///
/// - https://tools.ietf.org/html/rfc7469
///
/// Additional information:
///
/// - https://noncombatant.org/2015/05/01/about-http-public-key-pinning/
/// - https://developer.mozilla.org/en-US/docs/Web/HTTP/Public_Key_Pinning
///
final class ServerTrustEvaluator {

    // tag used to add and find the key in the Keychain
    static let keychainPublicKeyTag = "com.mindera.alicerce.ServerTrustEvaluator.keychainPublicKeyTag"

    let configuration: Configuration

    // MARK: - Lifecycle

    init(configuration: Configuration) throws {

        self.configuration = configuration
    }

    // MARK: - methods

    func evaluate(_ trust: SecTrust, hostname: String) throws {

        let today = Date()

        for policy in configuration.pinningPolicies {
            do {
                let isPolicyExpired = policy.expirationDate < today

                switch (policy.domainName, policy.includeSubdomains, isPolicyExpired) {
                case (let domainName, false, false) where hostname == domainName,
                     (let domainName, true, false) where hostname.isSubdomain(of: domainName):
                    return try verifyPublicKeyPin(of: trust, hostname: hostname, pinnedHashes: policy.pinnedHashes)
                case (let domainName, false, true) where hostname == domainName,
                     (let domainName, true, true) where hostname.isSubdomain(of: domainName):
                    throw Error.domainPolicyExpired
                default:
                    break
                }
            } catch Error.domainPolicyExpired {
                throw Error.domainPolicyExpired
            } catch let error as PublicKeyPinVerificationError {
                throw Error.pinVerificationFailed(error)
            } catch {
                assertionFailure("🔥 Unexpected error \(error)")
            }
        }

        // at this point, we didn't match any policy in the configured policies
        throw Error.domainNotPinned
    }

    // MARK: - Private methods

    private func verifyPublicKeyPin(of trust: SecTrust,
                                    hostname: String,
                                    pinnedHashes: Set<CertificateSPKIBase64EncodedSHA256Hash>) throws {

        // perform an initial check using the default SSL validation in case it was disabled, as this gives us
        // revocation (only for EV?) and also ensures the certificate chain is sane, and also the full path that
        // successfully validated the chain

        // validate using a sane SSL policy to force hostname validation, even if the supplied trust has a bad policy
        // configured (such as one from `SecPolicyCreateBasicX509()`)
        let sslPolicy = SecPolicyCreateSSL(true, hostname as CFString)
        SecTrustSetPolicies(trust, sslPolicy)

        var trustError: CFError?

        guard SecTrustEvaluateWithError(trust, &trustError) else {
            throw PublicKeyPinVerificationError.evaluation(trustError)
        }

        let certificateChainLength = SecTrustGetCertificateCount(trust)

        for index in configuration.certificateCheckingOrder.indices(forChainLength: certificateChainLength) {
            guard let certificate = SecTrustGetCertificateAtIndex(trust, index) else {
                throw PublicKeyPinVerificationError.getCertificate(index)
            }

            do {
                let (publicKeyData, publicKeyAlgorithm) = try certificate.publicKeyDataAndAlgorithm()

                guard pinnedHashes.contains(publicKeyData.spkiHash(for: publicKeyAlgorithm)) else { continue }

                // TODO: perhaps add some `spkiHash` caching?
                return
            } catch let error as SecCertificate.PublicKeyExtractionError {
                throw PublicKeyPinVerificationError.extractPublicKey(error)
            } catch {
                assertionFailure("🔥 Unexpected error \(error)")
            }
        }

        // at this point, we didn't find any matching SPKI hash in the chain
        throw PublicKeyPinVerificationError.pinnedHashNotFound
    }
}

// MARK: - AuthenticationChallengeHandler

extension ServerTrustEvaluator: AuthenticationChallengeHandler {

    func handle(_ challenge: URLAuthenticationChallenge, completionHandler: @escaping CompletionHandlerClosure) {

        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            return completionHandler(.performDefaultHandling, nil)
        }

        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return completionHandler(.cancelAuthenticationChallenge, nil)
        }

        let serverHostname = challenge.protectionSpace.host

        do {
            try evaluate(serverTrust, hostname: serverHostname)

            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } catch Error.domainNotPinned where configuration.allowNotPinnedDomains {
            completionHandler(.performDefaultHandling, nil)
        } catch Error.domainPolicyExpired where configuration.allowExpiredDomainPolicies {
            completionHandler(.performDefaultHandling, nil)
        } catch {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}

// MARK: - Error types

extension ServerTrustEvaluator {

    enum Error: Swift.Error {
        case domainNotPinned
        case domainPolicyExpired
        case pinVerificationFailed(PublicKeyPinVerificationError)
    }

    enum PublicKeyPinVerificationError: Swift.Error {
        case evaluation(CFError?)
        case getCertificate(CFIndex)
        case extractPublicKey(SecCertificate.PublicKeyExtractionError)
        case pinnedHashNotFound
    }
}

// MARK: - Domain helpers

private extension String {

    func isSubdomain(of domain: String) -> Bool {

        // TODO: possibly perform some hostname validations, like total length (255), characters (ASCII only), more?

        let reverseSubDomainComponents = components(separatedBy: ".").reversed()
        let reverseDomainComponents = domain.components(separatedBy: ".").reversed()

        return zip(reverseSubDomainComponents, reverseDomainComponents).first { $0 != $1 }.map { _ in false } ?? true
    }
}
