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
        private let phone_marketing_allowed: Bool
        private let email_marketing_allowed: Bool
        
        init(
            isPhoneAllowed: Bool,
            isEmailAllowed: Bool
        ) {
            self.phone_marketing_allowed = isPhoneAllowed
            self.email_marketing_allowed = isEmailAllowed
        }
    }
    
    private let queries: Query
    
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
