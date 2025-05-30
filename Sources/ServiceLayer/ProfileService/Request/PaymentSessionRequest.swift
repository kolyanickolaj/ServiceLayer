//
//  PaymentSession.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 1/25/24.
//

import Foundation

public final class PaymentSessionRequest: BaseRequest, ModelRequest {
    
    public var zone: RequestZone {
        .private
    }
    
    public var baseURL: URL {
        ServiceLayer.constants.platformHost
    }
    
    public var method: HTTP.Method {
        .POST
    }

    public var path: String {
        "user/pay-session"
    }
    
    public var apiVersion: ApiVersion {
        .api
    }
    
    public var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        queries.append(.init(name: "method", value: methodQueryParam))
        return queries
    }
    
    public var payloadKey: String? {
        "data"
    }
    
    private let methodQueryParam: String
    
    init(method: String) {
        self.methodQueryParam = method
    }
}
