//
//  GamesListRequest+Response.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/27/22.
//

import SwiftyJSON
import Foundation

extension GamesListRequest: ModelRequest {
    
    typealias Model = Response

    struct Pagination: Codable {
        let page, perPage, totalPages, totalCount: Int
    }
    
    struct Response: Codable, JSONParsable {
        let items: [MDGame]
        let pagination: Pagination
    }
 
    var payloadKey: String? {
        return "data"
    }
}
