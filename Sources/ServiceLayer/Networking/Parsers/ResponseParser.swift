//
//  ResponseParser.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import Foundation
import SwiftyJSON

struct ResponseParser<Model> {

    private let parsing: (JSON) throws -> Model

    init<Parser: JSONParser>(parser: Parser) where Parser.Model == Model {
        self.parsing = { data in
            try parser.parse(data)
        }
    }

    func parse(_ json: JSON) throws -> Model {
        try parsing(json)
    }
    
    func parse(_ data: Data) throws -> Model {
        let json = try JSON(data: data)
        return try parsing(json)
    }
}
