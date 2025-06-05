//
//  ProvincesRequest+Model.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//

import Foundation

typealias Province = ProvincesRequest.Model

extension ProvincesRequest: ModelRequest {
    
    struct Model: Codable, JSONParsable {
        let id: Int
        let name: String
        let countryAlpha2Code: String
    }
    
    var payloadKey: String? {
        "data.items"
    }
}
