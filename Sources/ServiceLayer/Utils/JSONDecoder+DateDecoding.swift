//
//  JSONDecoder+DateDecoding.swift
//  Tonywin
//
//  Created by Andrey on 7/31/23.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {

    static var iso8601Custom = custom { decoder in
        let dateStr = try decoder.singleValueContainer().decode(String.self)
        let customIsoFormatter = Formatter.customISO8601DateFormatter
        if let date = customIsoFormatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.dataCorrupted(
            DecodingError.Context(codingPath: decoder.codingPath,
                                  debugDescription: "Invalid date"))
    }
    
    static var iso8601GMT3 = custom { decoder in
        let dateStr = try decoder.singleValueContainer().decode(String.self)
        let customIsoFormatter = Formatter.customISO8601DateFormatter
        if let date = customIsoFormatter.date(from: dateStr) {
            return date
        }
        throw DecodingError.dataCorrupted(
            DecodingError.Context(codingPath: decoder.codingPath,
                                  debugDescription: "Invalid date"))
    }
}
