//
//  JSONParser.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import SwiftyJSON

protocol JSONParser {
    associatedtype Model

    func parse(_ json: JSON) throws -> Model
}
