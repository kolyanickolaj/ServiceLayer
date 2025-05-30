//
//  ResetPasswordRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/29/23.
//

import Foundation

public final class ResetPasswordRequest: BaseRequest {
    struct Query: Codable {
        let type: Int
        let email: String
    }

    private let queries: Query

    public var method: HTTP.Method {
        .POST
    }

    public var path: String {
        "user/password/reset"
    }
    
    public var apiVersion: ApiVersion {
        .v2
    }
    
    public func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
    }

    init(queries: Query) {
        self.queries = queries
    }
}
