//
//  Category.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/6/24.
//

import Foundation

typealias GameCategory = CasinoCategory

struct CasinoCategory: Codable, Hashable, JSONParsable {
    let id: Int
    let name: String
    let slug: String
    let dev_id: String?
}
