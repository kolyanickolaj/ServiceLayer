//
//  Category.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/6/24.
//

import Foundation

public typealias GameCategory = CasinoCategory

public struct CasinoCategory: Codable, Hashable, JSONParsable {
    let id: Int
    let name: String
    let slug: String
    let dev_id: String?
}
