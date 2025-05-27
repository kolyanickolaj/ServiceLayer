//
//  GameProducerRequest+Parsable.swift
//  CasinoApp
//
//  Created by Andrey Polyashev on 2/14/23.
//

import SwiftyJSON
import Foundation

extension GameProducerRequest: ModelRequest {
    
    typealias Model = Producer
    
    var payloadKey: String? {
        "data"
    }
}
