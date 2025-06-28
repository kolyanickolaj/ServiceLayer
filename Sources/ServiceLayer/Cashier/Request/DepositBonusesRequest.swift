//
//  DepositBonusesRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 28.06.25.
//

import Foundation

final class DepositBonusesRequest: BaseRequest, ModelRequest {

    typealias Model = Bonus
    
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
        "user/bonus/deposit-available"
    }
    
    var apiVersion: ApiVersion {
        .v2
    }

    var payloadKey: String? {
        "data.items"
    }
}
