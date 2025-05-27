//
//  SignUpValidationRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation

final class SignUpValidationRequest: BaseRequest {
    
    struct PhoneQuery: Codable {
        let phone: String
        let prefix: String
    }

    private let queries: Codable

    var method: HTTP.Method {
        .POST
    }
    
    var path: String? {
        "registration/validation"
    }
    
    func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
    }
    
    var apiVersion: ApiVersion {
        .v2
    }

    init(queries: Codable) {
        self.queries = queries
    }
}
