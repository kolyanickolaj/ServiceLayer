//
//  JSONToDataConverter.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/27/23.
//

import Foundation
import SwiftyJSON

public final class JSONToDataConverter {
    
    public static func convert<T: Codable>(model: T) -> Data? {
        return try? JSONEncoder().encode(model)
    }
    
    public static func convert<T: Codable>(data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    public static func convert<T: JSONParsable>(model: T) -> Data? {
        let a = try? JSON(model).rawData()
        return a
    }
    
    public static func convert<T: JSONParsable>(data: Data) -> T? {
        guard let json = try? JSON(data: data) else {
            return nil
        }
        return try? T.from(json)
    }
}
