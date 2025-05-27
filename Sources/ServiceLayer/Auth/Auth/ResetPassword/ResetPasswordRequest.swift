//
//  ResetPasswordRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/29/23.
//

import Foundation

final class ResetPasswordRequest: BaseRequest {
    struct Query: Codable {
        let type: Int
        let email: String
    }

    private let queries: Query

    var method: HTTP.Method {
        .POST
    }

    var path: String? {
        "user/password/reset"
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
    }

    init(queries: Query) {
        self.queries = queries
    }
}
