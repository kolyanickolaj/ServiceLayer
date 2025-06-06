//
//  SignUpRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/4/23.
//

import Foundation

public final class SignUpRequest: BaseRequest {
    private let params: Params
    
    public struct Signature {
        public let timestamp: Int
        public let signature: String
        
        public init(timestamp: Int, signature: String) {
            self.timestamp = timestamp
            self.signature = signature
        }
    }
    
    public struct Params {
        public let queries: Query
        public let timestamp: Int
        public let signature: String
        
        public init(queries: Query, timestamp: Int, signature: String) {
            self.queries = queries
            self.timestamp = timestamp
            self.signature = signature
        }
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
