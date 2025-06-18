//
//  Account.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation

public struct Account: Codable, JSONParsable {
    public let id: Int
    public let currency: String
    public let amount: Decimal
    public let isMain: Bool
    public let availableBonuses: Decimal
    public let currencyName: String
    public let availableForWithdrawal: Decimal

    enum CodingKeys: String, CodingKey {
        case id, currency, amount
        case isMain = "is_main"
        case availableBonuses = "available_bonuses"
        case currencyName = "currency_name"
        case availableForWithdrawal
    }
}
