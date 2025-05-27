//
//  Translations.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/26/23.
//

import Foundation
import SwiftyJSON
import ServiceLayer

struct Translations: JSONParsable {
    
    let dict: JSON
    let flat: [String: String]
    
    init(dict: JSON) {
        self.dict = dict
        self.flat = Self.flatten(dictionary: dict)
    }
    
    init() {
        self.dict = .init()
        self.flat = [:]
    }
    
    subscript(key: String) -> String? {
        if let value = dict.keyPath(key)?.string {
            return value
        }
        if let value = flat[key] {
            return value
        } else if let last = key.components(separatedBy: "_._").last {
            return String(last)
        } else {
            return key
        }
    }
    
    static func from(_ json: JSON) -> Translations? {
        return .init(dict: json)
    }
    
    private static func flatten(dictionary: JSON) -> [String: String] {
        func flattenRec(output: inout [String: String], keyPath: String, value: JSON) {
            if let value = value.string {
                output[keyPath] = value
            }
            if let dict = value.dictionary {
                dict.forEach { key, value in
                    flattenRec(output: &output, keyPath: "\(keyPath)_._\(key)", value: value)
                }
            }
        }
        
        var outputDict = [String: String]()
        
        dictionary.forEach { key, value in
            flattenRec(output: &outputDict, keyPath: key, value: value)
        }
        
        return outputDict
    }
}
