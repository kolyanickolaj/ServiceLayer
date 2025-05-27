//
//  ModelRequestJSONParser.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import SwiftyJSON

struct ModelRequestJSONParser<Model: JSONParsable>: JSONParser {

    private let payloadKey: String?
    private let requestPath: String?

    init<Request: ModelRequest>(request: Request) where Request.Model == Model {
        payloadKey = request.payloadKey
        requestPath = request.path
    }

    func parse(_ json: JSON) throws -> Model {
        guard let payload = json.keyPath(payloadKey) else {
            throw ParsingErrors.payloadParsingError
        }

        if let model: Model = model(json: payload) {
            return model
        }

        if let first = payload.arrayValue.first,
           let model: Model = model(json: first) {
            return model
        }
        #if DEBUG
        print("🔴 Failed to decode '\(Model.self)' for request: \(requestPath ?? "")\n\(json)")
        #endif

        throw ParsingErrors.payloadParsingError
    }

    func model<T: JSONParsable>(json: JSON) -> T? {
        return T.from(json)
    }
}
