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
        let isEmailAllowed: Int
        let notificationsEnabled: Bool
    }
    
    private let queries: Query
    
    var zone: RequestZone {
        .private
    }
    
    var headers: HTTP.Headers? {
        ["Content-Type":"application/x-www-form-urlencoded"]
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
    
    func makeBody() throws -> Data? {
        var components = URLComponents()
        components.queryItems = [
            .init(name: "email_marketing_allowed", value: "\(queries.isEmailAllowed)"),
            .init(name: "notificationsEnabled", value: "\(queries.notificationsEnabled)")
        ]
        return components.percentEncodedQuery?.data(using: .utf8)
    }
}
