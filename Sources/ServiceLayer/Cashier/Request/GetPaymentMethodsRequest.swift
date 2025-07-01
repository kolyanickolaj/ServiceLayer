//
//  GetPaymentMethodsRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class GetPaymentMethodsRequest: BaseRequest, ModelRequest {

    typealias Model = PaymentSessionInfo
    
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
        "user/pay-session-deposit"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
}
