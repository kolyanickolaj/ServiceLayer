//
//  PaymentSession.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 1/25/24.
//

import Foundation

final class PaymentSessionRequest: BaseRequest, ModelRequest {
    
    var zone: RequestZone {
        .private
    }
    
    var baseURL: URL {
        ServiceLayer.constants.platformHost
    }
    
    var method: HTTP.Method {
        .POST
    }

    var path: String? {
        "user/pay-session"
    }
    
    var apiVersion: ApiVersion {
        .api
    }
    
    var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        queries.append(.init(name: "method", value: methodQueryParam))
        return queries
    }
    
    var payloadKey: String? {
        "data"
    }
    
    private let methodQueryParam: String
    
    init(method: String) {
        self.methodQueryParam = method
    }
}
