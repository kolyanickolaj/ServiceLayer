//
//  Bonus.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

public struct Bonus: Codable, JSONParsable {
    public let name: String
    public let id: Int
    public let currency: String
    public let amount: Double
    public let baseCurrency: String
    public let amountInBaseCurrency: Double
    
    enum CodingKeys: String, CodingKey {
        case currency, baseCurrency, name
        case id = "bonusId"
        case amount = "bonusAmount"
        case amountInBaseCurrency = "bonusAmountInBaseCurrency"
    }
}
