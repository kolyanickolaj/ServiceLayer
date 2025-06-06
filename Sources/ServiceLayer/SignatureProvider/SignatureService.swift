//
//  SignatureService.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/20/23.
//

import Foundation
import CryptoKit
import CommonCrypto
import Security

public protocol ISignatureService {
    func signature(for data: Data) throws -> String
}

public struct SignatureService: ISignatureService {
    let privateKeyRawRepresentation: Data

    public func signature(for data: Data) throws -> String {
        let privateKey = try P256.Signing.PrivateKey(
            rawRepresentation: privateKeyRawRepresentation
        )

        return try privateKey.signature(for: data)
            .derRepresentation
            .hexEncoded
    }
}

private extension Data {
    var hexEncoded: String {
        reduce("") { $0 + String(format: "%02x", $1) }
    }
}
