//
//  GetPaymentMethodsRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class GetPaymentMethodsRequest: BaseRequest, ModelRequest {
    let operation: PaymentOperation
    
    init(operation: PaymentOperation) {
        self.operation = operation
    }
    
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
        "user/pay-session-\(operation.rawValue)"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
}
