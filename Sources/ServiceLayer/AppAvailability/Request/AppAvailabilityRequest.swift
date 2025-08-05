//
//  AppAvailabilityRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 16.06.25.
//

import Foundation

public final class AppAvailabilityRequest: BaseRequest {
    struct Query: Codable {
        let latitude: Double
        let longitude: Double
    }

    private let queries: Query

    public var zone: RequestZone {
        .private
    }
    
    public var method: HTTP.Method {
        .GET
    }

    public var path: String {
        "data/app-availability"
    }
    
    public var apiVersion: ApiVersion {
        .v2
    }
    
    public var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        queries.append(.init(name: "coordinates[latitude]", value: String(self.queries.latitude)))
        queries.append(.init(name: "coordinates[longitude]", value: String(self.queries.longitude)))
        return queries
    }

    init(queries: Query) {
        self.queries = queries
    }
}

extension AppAvailabilityRequest: ModelRequest {
    public typealias Model = AppAvailabilityResponse
    
    public var payloadKey: String? {
        "data"
    }
}
