//
//  PromotionsRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 5.07.25.
//

import Foundation

final class PromotionsRequest: BaseRequest, ModelRequest {

    typealias Model = Promotion
    
    struct Query: Codable {
        let language: String
    }
    
    private let queries: Query
    
    public var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        queries.append(.init(name: "lang", value: self.queries.language))
        return queries
    }
    
    var zone: RequestZone {
        .private
    }
    
    var baseURL: URL {
        //TODO: fix later
        URL(string: "https://nationalcasino.com")!
//        ServiceLayer.constants.host
    }
    
    var method: HTTP.Method {
        .GET
    }

    var path: String {
        "promotion/list"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
    
    init(queries: Query) {
        self.queries = queries
    }
}
