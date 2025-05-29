//
//  ResetPasswordRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/29/23.
//

import Foundation

public typealias ResetPasswordResponseModel = ResetPasswordRequest.Model

extension ResetPasswordRequest: ModelRequest {
    
    public struct Model: Codable, JSONParsable {
        let messages: String
    }
    
    public var payloadKey: String? {
        "data"
    }
}
