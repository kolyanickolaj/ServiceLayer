//
//  GetPreferencesRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

import Foundation

final class SavePreferencesRequest: BaseRequest, ModelRequest {
    typealias Model = SavePreferencesResponse
    
    struct Query: Codable {
        let isPhoneAllowed: Bool
        let isEmailAllowed: Bool
        
        init(
            isPhoneAllowed: Bool,
            isEmailAllowed: Bool
        ) {
            self.isPhoneAllowed = isPhoneAllowed
            self.isEmailAllowed = isEmailAllowed
        }
    }
    
    private let queries: Query
    
    var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        queries.append(.init(name: "phone_marketing_allowed", value: String(self.queries.isPhoneAllowed)))
        queries.append(.init(name: "email_marketing_allowed", value: String(self.queries.isEmailAllowed)))
        return queries
    }
    
    var zone: RequestZone {
        .private
    }
    
    var method: HTTP.Method {
        .POST
    }

    var path: String {
        "user/preferences/save"
    }
    
    var apiVersion: ApiVersion {
        .api
    }
    
    var payloadKey: String? {
        ""
    }
    
    init(queries: Query) {
        self.queries = queries
    }
}
