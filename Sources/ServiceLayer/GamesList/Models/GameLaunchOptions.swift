//
//  GameLaunchOptions.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/27/22.
//

import SwiftyJSON
import Foundation

public struct GameLaunchOptions: Codable, JSONParsable {
    public let gameURL: URL?
    public let strategy: String
    public let mobileUrl: URL?
   
    public static func from(_ json: JSON) -> GameLaunchOptions? {
        let gameUrl = json["game_url"].url
        let mobileUrl = json["mobile_url"].url
        let strategy = json["strategy"].stringValue
        return GameLaunchOptions(gameURL: gameUrl,
                                 strategy: strategy,
                                 mobileUrl: mobileUrl)  
    }
}
