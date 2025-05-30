//
//  ProfileRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation

final class ProfileRequest: BaseRequest, ModelRequest {

    typealias Model = Profile
    
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
        "user/get-info"
    }
    
    var apiVersion: ApiVersion {
        .v2
    }

    var payloadKey: String? {
        "data.user"
    }
}
