//
//  AddFavoriteGameRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class AddFavoriteGameRequest: BaseRequest, ModelRequest {
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
    
    func makeBody() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(queries)
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
    
    var zone: RequestZone {
        .private
    }
    
    // MARK: - ModelRequest
    
    typealias Model = AddFavoriteGameResponse
    
    var payloadKey: String? {
        ""
    }
}
