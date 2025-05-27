//
//  GamesListQuery.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/17/22.
//

import Foundation

extension GamesListRequest {
    
    struct Query: Codable {
        let searchText: String?
        let categoryId: Int?
        let producerId: Int?
        let hasLive: Bool
        let devId: String?
        let page: Int
        let perPage: Int
    }
}
