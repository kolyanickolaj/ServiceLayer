//
//  CategoryRequest.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/12/24.
//

import Foundation

final class CategoryRequest: BaseRequest, ModelRequest {
    
    // MARK: - Properties
    
    var method: HTTP.Method {
        .GET
    }
    
    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        items.append(.init(name: "isLive", value: "0"))
        items.append(.init(name: "auth", value: "false"))
        return items
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var path: String? {
        "casino/category"
    }
    
    // MARK: - ModelRequest
    
    typealias Model = CasinoCategory
    
    var payloadKey: String? {
        "data"
    }
}
