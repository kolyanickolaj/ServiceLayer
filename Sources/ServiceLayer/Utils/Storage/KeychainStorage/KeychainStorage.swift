//
//  TokenStorageService.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 08.11.2023.
//

import Foundation

private enum KeychainErrors: Error {
    case duplicateItem
    case notData
    case unknown(status: OSStatus)
}

protocol IKeychainStorage {

    func saveAccessToken(_ token: String) throws
    func getAccessToken() throws -> String?
    func deleteAccessToken() throws
}

final class KeychainStorage: IKeychainStorage {

    // MARK: - Properties

    private static let access_token_key = "auth_token"

    // MARK: - IKeychainStorageService

    func saveAccessToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else { return }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: KeychainStorage.access_token_key,
            kSecValueData: data as Any
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        guard status != errSecDuplicateItem else {
            try putAccessToken(from: data)
            return
        }

        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status: status)
        }
    }

    func getAccessToken() throws -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: KeychainStorage.access_token_key,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary

        var reference: AnyObject?
        let status = SecItemCopyMatching(query, &reference)

        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status: status)
        }

        guard let data = reference as? Data else { return nil }

        return String(decoding: data, as: UTF8.self)
    }

    func deleteAccessToken() throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: KeychainStorage.access_token_key as Any
        ] as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess else {
            throw KeychainErrors.notData
        }
    }

    // MARK: - Private

    private func putAccessToken(from data: Data) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: KeychainStorage.access_token_key as Any
        ] as CFDictionary

        let updateToken = [kSecValueData: data as Any] as CFDictionary

        let status = SecItemUpdate(query, updateToken)

        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status: status)
        }
    }
}
