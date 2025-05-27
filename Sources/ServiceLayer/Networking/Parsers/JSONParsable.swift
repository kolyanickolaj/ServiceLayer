//
//  JSONParsable.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import SwiftyJSON
import Foundation

public protocol JSONParsable {
    static func from(_ json: JSON) -> Self?
}

public extension JSONParsable where Self: Codable {
    static func from(_ json: JSON) -> Self? {
        do {
            let data = try json.rawData()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601Custom
            return try decoder.decode(Self.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

extension String: JSONParsable {}
