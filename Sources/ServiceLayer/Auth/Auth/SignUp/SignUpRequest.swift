//
//  SignUpRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/4/23.
//

import Foundation

final class SignUpRequest: BaseRequest {
    
    private let params: Params
    
    struct Signature {
        let timestamp: Int
        let signature: String
    }
    
    struct Params {
        let queries: Query
        let timestamp: Int
        let signature: String
    }
    
    var method: HTTP.Method {
        .POST
    }
    
    var path: String? {
        "registration"
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var headers: HTTP.Headers? {
        var headers = defaultHeaders
        headers["X-Signature"] = params.signature
        headers["X-Timestamp"] = "\(params.timestamp)"
        return headers
    }
    
    func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(params.queries)
    }
    
    init(params: Params) {
        self.params = params
    }
}
