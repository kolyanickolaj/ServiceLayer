//
//  GameSessionRequest.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/27/22.
//

import Foundation

public final class GameSessionRequest: BaseRequest {
    
    struct Body: Codable {
        struct Data: Codable {
            let user_identifier: String
            let game_identifier: String
            let mobile: Bool
            let strategy: String
        }
        
        let data: Data
    }
    
    // MARK: - Properties
    
    public var zone: RequestZone {
        .private
    }
    
    public var method: HTTP.Method {
        .POST
    }
    
    public var apiVersion: ApiVersion {
        .api
    }
    
    public var path: String {
        "casino/create-game-session"
    }
    
    public func makeBody() throws -> Data? {
        let body = Body(data: .init(user_identifier: "null", game_identifier: gameIdentifier, mobile: true, strategy: "redirect"))
        let encoder = JSONEncoder()
        return try encoder.encode(body)
    }
    
    private let gameIdentifier: String
    
    // MARK: - Inits
    
    init(gameIdentifier: String) {
        self.gameIdentifier = gameIdentifier
    }
}
