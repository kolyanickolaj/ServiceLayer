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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let isPhoneEnabledInt = try container.decode(Int.self, forKey: .isPhoneEnabled)
        self.isPhoneEnabled = isPhoneEnabledInt == 1
        let isEmailEnabledInt = try container.decode(Int.self, forKey: .isEmailEnabled)
        self.isEmailEnabled = isEmailEnabledInt == 1
    }
}
