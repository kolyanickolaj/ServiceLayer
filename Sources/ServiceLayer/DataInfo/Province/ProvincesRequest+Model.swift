//
//  ProvincesRequest+Model.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//

import Foundation

public typealias Province = ProvincesRequest.Model

extension ProvincesRequest: ModelRequest {
    
    public struct Model: Codable, JSONParsable {
        public let id: Int
        public let name: String
        public let countryAlpha2Code: String
    }
    
    public var payloadKey: String? {
        "data.items"
    }
}
