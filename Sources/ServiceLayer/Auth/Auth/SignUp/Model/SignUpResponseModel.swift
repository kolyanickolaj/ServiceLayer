//
//  SignUpResponseModel.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

public typealias SignUpResponseModel = SignUpRequest.Model

extension SignUpRequest: ModelRequest {
    public struct Model: Codable, JSONParsable {
        public let id: Int
        public let token: String
    }
    
    public var payloadKey: String? {
        "data"
    }
}
