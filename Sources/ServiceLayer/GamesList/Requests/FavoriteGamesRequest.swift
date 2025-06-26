//
//  FavoriteGamesRequest.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Foundation

final class FavoriteGamesRequest: BaseRequest {
    var method: HTTP.Method {
        .GET
    }
    
    var apiVersion: ApiVersion {
        .v2
    }
    
    var path: String {
        "casino/favorite-games/list"
    }
    
    var zone: RequestZone {
        .private
    }
}

extension FavoriteGamesRequest: ModelRequest {
    typealias Model = Response

    struct Pagination: Codable {
        let page, perPage, totalPages, totalCount: Int
    }

    struct Response: Codable, JSONParsable {
        let items: [MDGame]
        let pagination: Pagination
    }

    var payloadKey: String? {
        "data"
    }
}
