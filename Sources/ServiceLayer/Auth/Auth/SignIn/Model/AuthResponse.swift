//
//  AuthResponse.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation

// MARK: - Welcome

public struct Welcome: Codable {
    let data: AuthResponse
    let code: Int
    let status: String
}

// MARK: - DataClass

public struct AuthResponse: Codable, JSONParsable {
    public let token: String
    let id: Int
    let bmToken: String
    let bindingContracts: BindingContracts
    let notification: Notification
}

// MARK: - Notification

public struct Notification: Codable {
    let ibanVerification: IbanVerification
    let lastLogoutAt, lastLoggedIn: String
}

// MARK: - IbanVerification

public struct IbanVerification: Codable {
    let ibanVerificationRequired: Bool

    enum CodingKeys: String, CodingKey {
        case ibanVerificationRequired = "required"
    }
}

public struct BindingContracts: Codable {
    public let termsAndConditionsAccepted: Bool
    public let privacyPolicyAccepted: Bool
}
