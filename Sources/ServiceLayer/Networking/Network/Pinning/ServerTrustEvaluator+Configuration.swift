import Foundation
import CryptoKit

extension ServerTrustEvaluator {

    typealias CertificateSPKIBase64EncodedSHA256Hash = String

    enum PinningPolicyValidationError: Swift.Error {
        case invalidDomainName
        case emptyPins
        case invalidPins(Set<CertificateSPKIBase64EncodedSHA256Hash>)
        case missingBackupPin
    }

    struct PinningPolicy {
        let domainName: String
        let includeSubdomains: Bool
        let expirationDate: Date
        let pinnedHashes: Set<CertificateSPKIBase64EncodedSHA256Hash>
        let enforceBackupPin: Bool

        // TODO: possibly add more configurations, like additional trust anchors, optional `reportURIs`

        init(domainName: String,
                    includeSubdomains: Bool = false,
                    expirationDate: Date = Date.distantFuture,
                    pinnedHashes: Set<CertificateSPKIBase64EncodedSHA256Hash>,
                    enforceBackupPin: Bool = true) throws {

            // validate domain name
            guard !domainName.isEmpty else { throw PinningPolicyValidationError.invalidDomainName }
            // TODO: possibly add other validations, like excluding `*.com`

            // validate pins
            guard !pinnedHashes.isEmpty else { throw PinningPolicyValidationError.emptyPins }

            let invalidPins = pinnedHashes.filter { Data(base64Encoded: $0)?.count ?? 0 != SHA256.Digest.byteCount }
            guard invalidPins.isEmpty else { throw PinningPolicyValidationError.invalidPins(Set(invalidPins)) }

            // validate backup pin enforcing
            if enforceBackupPin && pinnedHashes.count == 1 { throw PinningPolicyValidationError.missingBackupPin }

            self.domainName = domainName
            self.includeSubdomains = includeSubdomains
            self.expirationDate = expirationDate
            self.pinnedHashes = pinnedHashes
            self.enforceBackupPin = enforceBackupPin
        }
    }

    enum CertificateCheckingOrder {
        case rootToLeaf
        case leafToRoot

        func indices(forChainLength chainLength: Int) -> StrideTo<Int> {
            assert(chainLength > 0)

            switch self {
            case .rootToLeaf: return stride(from: chainLength - 1, to: -1, by: -1)
            case .leafToRoot: return stride(from: 0, to: chainLength, by: 1)
            }
        }
    }

    enum ConfigurationValidationError: Swift.Error {
        case emptyPolicies
    }

    struct Configuration {
        let pinningPolicies: Set<PinningPolicy>
        let certificateCheckingOrder: CertificateCheckingOrder
        let allowNotPinnedDomains: Bool
        let allowExpiredDomainPolicies: Bool

        init(pinningPolicies: Set<PinningPolicy>,
                    certificateCheckingOrder: CertificateCheckingOrder = .leafToRoot,
                    allowNotPinnedDomains: Bool = false,
                    allowExpiredDomainPolicies: Bool = true) throws {

            // validate policy count
            guard !pinningPolicies.isEmpty else { throw ConfigurationValidationError.emptyPolicies }

            self.pinningPolicies = pinningPolicies
            self.certificateCheckingOrder = certificateCheckingOrder
            self.allowNotPinnedDomains = allowNotPinnedDomains
            self.allowExpiredDomainPolicies = allowExpiredDomainPolicies
        }
    }
}

extension ServerTrustEvaluator.PinningPolicy: Hashable {

    static func == (lhs: ServerTrustEvaluator.PinningPolicy, rhs: ServerTrustEvaluator.PinningPolicy) -> Bool {
        return lhs.domainName == rhs.domainName
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(domainName)
    }
}
