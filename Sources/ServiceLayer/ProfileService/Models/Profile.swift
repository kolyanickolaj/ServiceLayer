//
//  Profile.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation

public struct Profile: Codable, JSONParsable {
    public let id: Int
    public let email: String
    public let nickname: String?
    public let firstName, lastName: String
    public let middleName, address, postCode, city: String?
    public let birthday, userPrefix, phone: String
    public let isVerified: Int
    public let createdAt: String
    public let suburb: String?
    public let gender: Int
    public let currency: String
    public let accounts: [Account]
    public let locale: String?
    public let country: Country
    public let disabledStatusCode: Int
    public let isActivated, isNeedCompleteRegistration, isNeedCompleteMigration, isNeedCurrentPasswordWhenChanging: Bool
    public let bindingContracts: BindingContracts
    public let acceptBonuses: Bool
    public let bonusType: Int
    public let compPointAccounts: CompPointAccounts
    public let compPointSportResetAt: String
    public let compPointCasinoResetAt: String?
    public let firstDeposit: Bool

    enum CodingKeys: String, CodingKey {
        case id, email, nickname
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case address, birthday, city
        case userPrefix = "prefix"
        case phone, isVerified, createdAt, gender, currency, accounts, locale, country
        case disabledStatusCode, isActivated, isNeedCompleteRegistration
        case isNeedCompleteMigration, isNeedCurrentPasswordWhenChanging, bindingContracts
        case postCode = "post_code"
        case suburb
        
        case acceptBonuses = "accept_bonuses"
        case bonusType, compPointAccounts, compPointSportResetAt, compPointCasinoResetAt
//        case isVipForbidden = "is_vip_forbidden"
//        case reactivationSent = "reactivation_sent"
        case firstDeposit = "first_deposit"
//        case accounts, locale, country, disabledStatusCode, groups
//        case isSessionLimitHit = "is_session_limit_hit"
//        case isBalanceLimitHit = "is_balance_limit_hit"
    }
    
    public struct Country: Codable {
        public let id: Int
        public let code, name: String
        public let flagURL: ImageUrl

        enum CodingKeys: String, CodingKey {
            case id, code, name
            case flagURL = "flagUrl"
        }
    }
}
