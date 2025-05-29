//
//  SignUpValidationResponseModel.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation

public typealias SignUpValidationResponseModel = SignUpValidationRequest.Model

extension SignUpValidationRequest: ModelRequest {
    
    public struct Model: Codable, JSONParsable {
        let status: String
        let code: Int
    }
    
    public var payloadKey: String? {
        nil
    }
}
