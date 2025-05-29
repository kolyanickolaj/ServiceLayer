//
//  CreateSessionResponse.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/27/22.
//

import SwiftyJSON
import Foundation

public struct GameSessionResponse: Codable, JSONParsable {
    
     let launchOptions: GameLaunchOptions
     let gameLaunchUrl: String?

    public static func from(_ json: JSON) -> GameSessionResponse? {
        let launchOptionsJson = json["launch_options"]
        let gameLaunchUrl = json["gameLaunchUrl"].string
        guard let launchOptions = GameLaunchOptions.from(launchOptionsJson) else {
            return nil
        }
        
        return GameSessionResponse(launchOptions: launchOptions, gameLaunchUrl: gameLaunchUrl)
    }
}
