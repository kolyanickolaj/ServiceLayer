//
//  SignUpResponseModel.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

typealias SignUpResponseModel = SignUpRequest.Model

extension SignUpRequest: ModelRequest {
    
    struct Model: Codable, JSONParsable {
        let id: Int
        let token: String
    }
    
    var payloadKey: String? {
        return "data"
    }
}
