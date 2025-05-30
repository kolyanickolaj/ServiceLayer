//
//  SignUpRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/4/23.
//

import Foundation

public final class SignUpRequest: BaseRequest {
    
    private let params: Params
    
    struct Signature {
        let timestamp: Int
        let signature: String
    }
    
    public struct Params {
        let queries: Query
        let timestamp: Int
        let signature: String
    }
    
    public var method: HTTP.Method {
        .POST
    }
    
    public var path: String {
        "registration"
    }
    
    public var apiVersion: ApiVersion {
        .v2
    }
    
    public var headers: HTTP.Headers? {
        var headers = defaultHeaders
        headers["X-Signature"] = params.signature
        headers["X-Timestamp"] = "\(params.timestamp)"
        return headers
    }
    
    public func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(params.queries)
    }
    
    init(params: Params) {
        self.params = params
    }
}
