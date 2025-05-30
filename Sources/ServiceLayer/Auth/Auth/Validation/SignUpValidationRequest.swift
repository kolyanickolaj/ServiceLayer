//
//  SignUpValidationRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation

public final class SignUpValidationRequest: BaseRequest {
    
    public struct PhoneQuery: Codable {
        let phone: String
        let prefix: String
    }

    private let queries: Codable

    public var method: HTTP.Method {
        .POST
    }
    
    public var path: String {
        "registration/validation"
    }
    
    public func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
    }
    
    public var apiVersion: ApiVersion {
        .v2
    }

    init(queries: Codable) {
        self.queries = queries
    }
}
