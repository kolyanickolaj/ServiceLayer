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
    
    public func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
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
