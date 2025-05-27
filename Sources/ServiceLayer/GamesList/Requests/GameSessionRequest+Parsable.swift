//
//  GameSessionRequest+Parsable.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/27/22.
//

import SwiftyJSON
import Foundation

extension GameSessionRequest: ModelRequest {
    
    typealias Model = GameSessionResponse
        
    var payloadKey: String? {
        "data"
    }
}
