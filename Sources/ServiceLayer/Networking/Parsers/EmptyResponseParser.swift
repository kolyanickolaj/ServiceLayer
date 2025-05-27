//
//  EmptyResponseParser.swift
//  CasinoBrand
//
//  Created by Andrey on 11/9/22.
//

import SwiftyJSON

struct EmptyResponseParser: JSONParser {
    typealias Model = Void

    func parse(_ json: JSON) throws -> Model {
        return Void()
    }
}
