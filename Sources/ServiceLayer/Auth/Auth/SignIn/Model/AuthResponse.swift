//
//  AuthResponse.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation

// MARK: - Welcome

public struct Welcome: Codable {
    public let data: AuthResponse
    public let code: Int
    public let status: String
}

// MARK: - DataClass

public struct AuthResponse: Codable, JSONParsable {
    public let token: String
    public let id: Int
    public let bmToken: String
    public let bindingContracts: BindingContracts
    public let notification: Notification
}

// MARK: - Notification

public struct Notification: Codable {
    public let ibanVerification: IbanVerification
    public let lastLogoutAt, lastLoggedIn: String
}

// MARK: - IbanVerification

public struct IbanVerification: Codable {
    public let ibanVerificationRequired: Bool

    enum CodingKeys: String, CodingKey {
        case ibanVerificationRequired = "required"
    }
}

public struct BindingContracts: Codable {
    public let termsAndConditionsAccepted: Bool
    public let privacyPolicyAccepted: Bool
}

public struct CompPointAccounts: Codable {
    public let casino, sport: Casino
}

public struct Casino: Codable {
    public let status: Int
    public let redeemable: Redeemable
}

public struct Redeemable: Codable {
    public let amount: Int
}
