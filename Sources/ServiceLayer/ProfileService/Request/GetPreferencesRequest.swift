//
//  GetPreferencesRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

import Foundation

final class GetPreferencesRequest: BaseRequest, ModelRequest {

    typealias Model = NotificationPreferences
    
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
        "user/preferences/get"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
}
