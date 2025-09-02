//
//  VerificationRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 29.08.25.
//

import Foundation

final class VerificationRequest: BaseRequest, ModelRequest {
    private let params: Params
    
    typealias Model = Document
    
    public struct Params {
        public let userId: Int
        
        public init(userId: Int) {
            self.userId = userId
        }
    }
    
    var zone: RequestZone {
        .private
    }
    
    var baseURL: URL {
        ServiceLayer.constants.platformHost
    }
    
    var method: HTTP.Method {
        .GET
    }

    var path: String {
        "user/documents/list/v2"
    }
    
    var headers: HTTP.Headers? {
        var headers = defaultHeaders
        headers["user_id"] = "\(params.userId)"
        return headers
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data.items"
    }
    
    init(params: Params) {
        self.params = params
    }
}
