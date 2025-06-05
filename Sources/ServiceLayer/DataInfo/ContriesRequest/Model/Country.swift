//
//  GetCountriesRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

struct Country: Codable, JSONParsable {
    private let hasProvinceInt: Int
    
    let id: Int
    let dialCode: String
    let name: String
    let flagUrl: ImageUrl
    let alpha2: String
    let hasFiscalRegions: Int
    let needConfirmationModal, hasPromoCodes: Bool
    var hasProvince: Bool { return hasProvinceInt == 1 }
    let requiredAge: Int
    
    enum CodingKeys: String, CodingKey {
        case id, dialCode, name, flagUrl
        case alpha2 = "alpha_2"
        case hasProvinceInt = "hasProvince"
        case hasFiscalRegions, needConfirmationModal, hasPromoCodes
        case requiredAge
    }
}
