//
//  PaymentSessionRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 1/25/24.
//

import SwiftyJSON

public typealias PaymentSession = PaymentSessionRequest.Model

extension PaymentSessionRequest {
    public struct Model: JSONParsable {
        let sessionId: String
        let merchantId: String
        
        public static func from(_ json: JSON) -> PaymentSessionRequest.Model? {
            guard
                let sessionId = json["session_id"].string,
                let merchantId = json["pgw_merchant_id"].string
            else { return nil }
            return Model(sessionId: sessionId, merchantId: merchantId)
        }
    }
}
