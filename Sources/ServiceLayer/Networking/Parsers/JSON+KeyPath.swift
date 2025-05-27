//
//  JSON+KeyPath.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import SwiftyJSON

extension JSON {
    
    public func keyPath(_ path: String?) -> JSON? {
        guard let path = path else {
            return self
        }
        var json: JSON? = self
        let kyes = path.split(separator: ".")
        kyes.forEach {
            let value = json?[String($0)]
            guard value?.error == nil else {
                json = nil
                return
            }
            json = value
        }

        return json
    }
}
