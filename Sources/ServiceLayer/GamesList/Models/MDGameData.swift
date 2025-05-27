//
//  MDGameData.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

 struct MDGameData: Codable {
     let total, perPage, pages: Int
     let games: [MDGame]
     let gameSuspended: Bool

    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case pages, games, gameSuspended
    }
}
