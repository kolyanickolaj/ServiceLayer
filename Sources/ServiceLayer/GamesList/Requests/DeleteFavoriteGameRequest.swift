//
//  DeleteFavoriteGameRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class DeleteFavoriteGameRequest: BaseRequest, ModelRequest {
    struct Query: Codable {
        private let gameId: Int
        
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
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var path: String {
        "casino/favorite-games/remove"
    }
    
    // MARK: - ModelRequest
    
    typealias Model = DeleteFavoriteGameResponse
    
    var payloadKey: String? {
        ""
    }
}
