import Foundation
import Security

extension SecCertificate {

    enum PublicKeyExtractionError: Swift.Error {
        case createTrust(OSStatus?)
        case copyPublicKey(SecTrust)
        case copyPublicKeyExternalRepresentation(SecKey, CFError?)
        case copyPublicKeyAttributes(SecKey)
        case unknownAlgorithm(SecKey, [CFString : Any])
        case addPublicKeyToKeychain(OSStatus)
        case deletePublicKeyFromKeychain(OSStatus)
        case getPublicKeyDataFromKeychain
    }

    func publicKeyDataAndAlgorithm() throws -> (Data, PublicKeyAlgorithm) {

        let publicKey = try self.publicKey()

        // copy the key bytes from the key reference
        var error: Unmanaged<CFError>?
        guard let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, &error) else {
            throw PublicKeyExtractionError.copyPublicKeyExternalRepresentation(publicKey, error?.takeRetainedValue())
        }

        guard let publicKeyAttributes = SecKeyCopyAttributes(publicKey) as? [CFString : Any] else {
            throw PublicKeyExtractionError.copyPublicKeyAttributes(publicKey)
        }

        guard let algorithm: PublicKeyAlgorithm = PublicKeyAlgorithm(secKeyAttributes: publicKeyAttributes) else {
            throw PublicKeyExtractionError.unknownAlgorithm(publicKey, publicKeyAttributes)
        }

        return (publicKeyData as Data, algorithm)
    }

    func publicKey() throws -> SecKey {

        // create an X509 trust for the certificate
        var newTrust: SecTrust?
        let policy = SecPolicyCreateBasicX509()

        switch SecTrustCreateWithCertificates(self, policy, &newTrust) {
        case errSecSuccess: break
        case let error: throw PublicKeyExtractionError.createTrust(error)
        }

        guard let trust = newTrust else { throw PublicKeyExtractionError.createTrust(nil) }

        // get a key reference from the certificate trust
        guard let publicKey = SecTrustCopyPublicKey(trust) else { throw PublicKeyExtractionError.copyPublicKey(trust) }

        return publicKey
    }
}
