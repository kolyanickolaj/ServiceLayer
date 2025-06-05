//
//  CurrenciesRequest+Model.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//

import Foundation

public typealias Currency = CurrenciesRequest.Model

extension CurrenciesRequest: ModelRequest {
    
    public struct Model: Codable, JSONParsable {
        public let enabled: Int
        public let codeNumber: String?
        public let code, name: String
        public let icon, iconURL: String?
    }
    
    public var payloadKey: String? {
        "data.currencies"
    }
}
