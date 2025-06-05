//
//  GetCountriesRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

public struct Country: Codable, JSONParsable {
    private let hasProvinceInt: Int
    
    public let id: Int
    public let dialCode: String
    public let name: String
    public let flagUrl: ImageUrl
    public let alpha2: String
    public let hasFiscalRegions: Int
    public let needConfirmationModal, hasPromoCodes: Bool
    public var hasProvince: Bool { return hasProvinceInt == 1 }
    public let requiredAge: Int
    
    enum CodingKeys: String, CodingKey {
        case id, dialCode, name, flagUrl
        case alpha2 = "alpha_2"
        case hasProvinceInt = "hasProvince"
        case hasFiscalRegions, needConfirmationModal, hasPromoCodes
        case requiredAge
    }
}
