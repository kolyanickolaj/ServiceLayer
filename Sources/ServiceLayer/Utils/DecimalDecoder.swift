//
//  DecimalDecoder.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 2/26/24.
//

import Foundation

@propertyWrapper
struct DecimalDecoder: Codable {
    let wrappedValue: Decimal

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Double.self) {
            self.wrappedValue = Decimal(value)
        } else if let value = try? container.decode(String.self),
                  let decimal = Decimal(string: value) {
            self.wrappedValue = decimal
        } else if let value = try? container.decode(Decimal.self) {
            self.wrappedValue = value
        } else {
            throw DefaultErrors.decodeModelFailed
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
