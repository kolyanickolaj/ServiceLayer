//
//  Preferences.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

public struct NotificationPreferences: Codable, JSONParsable {
    public let isEmailEnabled: Bool
    public let isPushEnabled: Bool
    
    public init(
        isPushEnabled: Bool = false,
        isEmailEnabled: Bool = false
    ) {
        self.isPushEnabled = isPushEnabled
        self.isEmailEnabled = isEmailEnabled
    }
    
    enum CodingKeys: String, CodingKey {
        case isPushEnabled = "notificationsEnabled"
        case isEmailEnabled = "email_marketing_allowed"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.isPushEnabled = try container.decode(Bool.self, forKey: .isPushEnabled)
        let isEmailEnabledInt = try container.decode(Int.self, forKey: .isEmailEnabled)
        self.isEmailEnabled = isEmailEnabledInt == 1
    }
}
