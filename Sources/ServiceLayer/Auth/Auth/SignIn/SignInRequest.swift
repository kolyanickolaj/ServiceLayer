//
//  SignInRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

final class SignInRequest: BaseRequest, ModelRequest {

    typealias Model = AuthResponse
    
    struct Query: Codable {
        let email: String
        let password: String
        let confirmationCode: String?
    }

    private let queries: Query

    var method: HTTP.Method {
        .POST
    }

    var path: String {
        "auth"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
    
    func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
    }

    init(queries: Query) {
        self.queries = queries
    }
}
