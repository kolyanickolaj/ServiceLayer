//
//  LoginError.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation
import SwiftyJSON

struct LoginError: Error {
    let apiCode: ErrorCode
    let networkCode: Int
    let messages: [String]
    let attributes: [String: String]

    static func error(_ json: JSON) -> Error? {
        let code = json["code"].intValue
        guard code == 400 || code == 403 else { return nil }
        let apiErrorCode = json["data"]["apiErrorCode"].intValue
        let errorCode = LoginError.ErrorCode(rawValue: apiErrorCode) ?? .unowned
        let messages = json["data"]["messages"].arrayValue.map { $0.stringValue }

        var attributes: [String: String] = [:]
        json["data"].forEach { (key, value) in
            guard key != "messages" else { return }
            attributes[key] = value.stringValue
        }
        return LoginError(
            apiCode: errorCode,
            networkCode: code,
            messages: messages,
            attributes: attributes
        )
    }
}

// MARK: - LocalizedError

extension LoginError: LocalizedError {

    var errorDescription: String? {
        return messages.joined(separator: "\n")
    }
}

// MARK: - Nasted / ErrorCode

extension LoginError {

    enum ErrorCode: Int {
        case secondFactorAuth  = 34
        case invalidCreds      = 23
        case selfExcludedUntil = 3
        case restrictedUntil   = 7
        case disabled          = 1
        case unowned
    }
}
