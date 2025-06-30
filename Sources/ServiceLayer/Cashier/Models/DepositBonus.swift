//
//  DepositBonus.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 28.06.25.
//

public struct DepositBonus: Codable, JSONParsable {
    public let title: String
    public let id: Int
    public let currency: String
    public let amount: Int
    public let imageUrl: String
    public let bonusCode: String
    public let percent: Int
    public let description: String
    public let freespins: Int
    
    enum CodingKeys: String, CodingKey {
        case imageUrl, title, bonusCode, id, description, freespins
        case amount = "maxAmount"
        case currency = "maxAmountCurrency"
        case percent = "bonusPercentage"
    }
}
