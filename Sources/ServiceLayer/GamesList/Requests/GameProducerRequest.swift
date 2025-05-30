//
//  GameProducerRequest.swift
//  CasinoApp
//
//  Created by Andrey Polyashev on 2/14/23.
//

import Foundation

final class GameProducerRequest: BaseRequest {
    
    // MARK: - Properties
    
    var method: HTTP.Method {
        .GET
    }
    
    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        items.append(.init(name: "is_live", value: "0"))
        return items
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var path: String {
        "casino/producer"
    }
}
