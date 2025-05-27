//
//  GamesListRequest.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/17/22.
//

import Foundation

final class GamesListRequest: BaseRequest {
    
    // MARK: - Properties
    
    var method: HTTP.Method { .GET }
    var apiVersion: ApiVersion { .v3 }
    var path: String { "casino/game" }
    
    var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        if let producerId = customQuery.producerId {
            queries.append(.init(name: "producer_id", value: String(producerId)))
        }
        
        if let title = customQuery.searchText {
            queries.append(.init(name: "title", value: title))
        } else if let categoryId = customQuery.categoryId {
            queries.append(.init(name: "category_id", value: String(categoryId)))
        }
        if let devId = customQuery.devId {
            queries.append(.init(name: "dev_id", value: devId))
        }
        queries.append(.init(name: "has_live", value: String(customQuery.hasLive)))
        queries.append(.init(name: "page", value: String(customQuery.page)))
        queries.append(.init(name: "perPage", value: String(customQuery.perPage)))
        queries.append(.init(name: "is_mobile", value: "1"))
        return queries
    }
    
    let customQuery: Query
    
    // MARK: - Inits
    
    init(query: Query) {
        self.customQuery = query
    }
}
