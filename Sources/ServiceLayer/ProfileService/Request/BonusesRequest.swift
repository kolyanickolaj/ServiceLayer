//
//  BonusesRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 24.06.25.
//

import Foundation

final class BonusesRequest: BaseRequest, ModelRequest {

    typealias Model = BonusList
    
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
        "user/bonuses/list"
    }
    
    var apiVersion: ApiVersion {
        .v3
    }

    var payloadKey: String? {
        "data"
    }
}
