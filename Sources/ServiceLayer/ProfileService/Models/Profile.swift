//
//  Profile.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation

struct Profile: Codable, JSONParsable {
    
    let id: Int
    let email: String
    let nickname: String?
    let firstName, lastName: String
    let middleName, address, postCode, city: String?
    let birthday, userPrefix, phone: String
    let isVerified: Int
    let createdAt: String
    let suburb: String?
    let gender: Int
    let currency: String
    let accounts: [Account]
    let locale: String?
    let country: Country
    let disabledStatusCode: Int
    let isActivated, isNeedCompleteRegistration, isNeedCompleteMigration, isNeedCurrentPasswordWhenChanging: Bool
    let bindingContracts: BindingContracts

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
    }
    
    struct Country: Codable {
        let id: Int
        let code, name: String
        let flagURL: ImageUrl

        enum CodingKeys: String, CodingKey {
            case id, code, name
            case flagURL = "flagUrl"
        }
    }
}
