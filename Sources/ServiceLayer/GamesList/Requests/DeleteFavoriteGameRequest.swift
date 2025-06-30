//
//  DeleteFavoriteGameRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class DeleteFavoriteGameRequest: BaseRequest, ModelRequest {
    struct Query: Codable {
        let gameId: Int
        
        init(
            gameId: Int
        ) {
            self.gameId = gameId
        }
    }
    
    private let queries: Query
    
    init(gameId: Int) {
        self.queries = Query(gameId: gameId)
    }
    
    var method: HTTP.Method {
        .DELETE
    }
    
    public func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var path: String {
        "casino/favorite-games/remove"
    }
    
    var zone: RequestZone {
        .private
    }
    
    // MARK: - ModelRequest
    
    typealias Model = DeleteFavoriteGameResponse
    
    var payloadKey: String? {
        ""
    }
}
