//
//  PaymentMethod.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

public struct PaymentSessionInfo: Codable, JSONParsable  {
    public let methods: [PaymentMethod]
    public let merchantId: String
    public let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case methods = "payment_methods"
        case merchantId = "pgw_merchant_id"
        case sessionId = "session_id"
    }
}

public struct PaymentMethod: Codable, JSONParsable  {
    public let id: String
    public let name: String
    public let logo: String
}
