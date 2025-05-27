//
//  ResetPasswordRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/29/23.
//

import Foundation

extension ResetPasswordRequest: ModelRequest {
    
    struct Model: Codable, JSONParsable {
        let messages: String
    }
    
    var payloadKey: String? {
        "data"
    }
}
