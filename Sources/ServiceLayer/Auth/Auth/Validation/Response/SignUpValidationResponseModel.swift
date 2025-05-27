//
//  SignUpValidationResponseModel.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/25/23.
//

import Foundation

extension SignUpValidationRequest: ModelRequest {
    
    struct Model: Codable, JSONParsable {
        let status: String
        let code: Int
    }
    
    var payloadKey: String? {
        return nil
    }
}
