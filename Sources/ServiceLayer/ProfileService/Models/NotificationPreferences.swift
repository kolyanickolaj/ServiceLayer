//
//  Preferences.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

public struct NotificationPreferences: Codable, JSONParsable {
    public let isEmailEnabled: Bool
    public let isPhoneEnabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case isPhoneEnabled = "phone_marketing_allowed"
        case isEmailEnabled = "email_marketing_allowed"
    }
}
