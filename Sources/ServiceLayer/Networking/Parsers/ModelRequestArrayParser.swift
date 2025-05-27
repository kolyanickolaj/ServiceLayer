//
//  ArrayParser.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import SwiftyJSON

struct ModelRequestArrayParser<T: JSONParsable>: JSONParser {

    typealias Model = [T]

    private let payloadKey: String?
    private let requestPath: String?

    init<Request: ModelRequest>(request: Request) where Request.Model == T {
        payloadKey = request.payloadKey
        requestPath = request.path
    }

    func parse(_ json: JSON) throws -> [T] {
        let jsonArray: [JSON] = {
            guard let payload = json.keyPath(payloadKey) else { return [] }
            if let array = payload.array { return array }
            if case .null = payload.type { return [] }
            return [payload]
        }()

        let models: [T] = jsonArray.compactMap(T.from(_:))

        #if DEBUG
        if models.count != jsonArray.count {
            print("🔴 Failed to decode \(jsonArray.count - models.count) models of \(String(describing: T.self)) for request: \(requestPath ?? "")")
        }
        #endif

        return models
    }
}
