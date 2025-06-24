//
//  BonusList.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

public struct BonusList: Codable, JSONParsable {
    public let items: [Bonus]
}

public struct Bonus: Codable, JSONParsable {
    public let id: Int
    public let currency: String
    public let amount: Int
    public let baseCurrency: String
    public let amountInBaseCurrency: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "bonusId"
        case currency, baseCurrency
        case amount = "bonusAmount"
        case amountInBaseCurrency = "bonusAmountInBaseCurrency"
    }
}
