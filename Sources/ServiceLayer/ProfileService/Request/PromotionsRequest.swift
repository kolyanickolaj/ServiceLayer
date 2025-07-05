//
//  PromotionsRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 5.07.25.
//

import Foundation

final class PromotionsRequest: BaseRequest, ModelRequest {

    typealias Model = Promotion
    
    var zone: RequestZone {
        .private
    }
    
    var baseURL: URL {
        ServiceLayer.constants.host
    }
    
    var method: HTTP.Method {
        .GET
    }

    var path: String {
        "promotion/list?lang=en"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
}
