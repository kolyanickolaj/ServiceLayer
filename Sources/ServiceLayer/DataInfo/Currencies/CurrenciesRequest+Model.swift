//
//  CurrenciesRequest+Model.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//

import Foundation

typealias Currency = CurrenciesRequest.Model

extension CurrenciesRequest: ModelRequest {
    
    struct Model: Codable, JSONParsable {
        let enabled: Int
        let codeNumber: String?
        let code, name: String
        let icon, iconURL: String?
    }
    
    var payloadKey: String? {
        "data.currencies"
    }
}
