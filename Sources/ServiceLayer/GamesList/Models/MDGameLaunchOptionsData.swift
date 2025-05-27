//
//  MDGameLaunchOptionsData.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

 struct MDGameLaunchOptionsData: Codable {
     let launchOptions: MDGameLaunchOptions
     let gameLaunchUrl: String?

    enum CodingKeys: String, CodingKey {
        case launchOptions = "launch_options"
        case gameLaunchUrl
    }
}
