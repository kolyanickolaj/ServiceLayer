//
//  AddFavoriteGameRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class AddFavoriteGameRequest: BaseRequest, ModelRequest {
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
        .POST
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var path: String {
        "casino/favorite-games/add"
    }
    
    // MARK: - ModelRequest
    
    typealias Model = AddFavoriteGameResponse
    
    var payloadKey: String? {
        ""
    }
}
