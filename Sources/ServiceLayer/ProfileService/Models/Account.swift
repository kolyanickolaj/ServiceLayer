//
//  Account.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation

struct Account: Codable, JSONParsable {
    let id: Int
    let currency: String
    let amount: Decimal
    let isMain: Bool
    let availableBonuses: Decimal
    let currencyName: String
    let availableForWithdrawal: Decimal

    enum CodingKeys: String, CodingKey {
        case id, currency, amount
        case isMain = "is_main"
        case availableBonuses = "available_bonuses"
        case currencyName = "currency_name"
        case availableForWithdrawal
    }
}
