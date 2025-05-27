//
//  MDGameLaunchOptions.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

struct MDGameLaunchOptions: Codable {
    let gameURL: String?
    let strategy: String
    let mobileUrl: String?
        
    enum CodingKeys: String, CodingKey {
        case gameURL = "game_url"
        case mobileUrl = "mobile_url"
        case strategy
    }
}
