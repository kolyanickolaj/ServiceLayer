//
//  Category.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/6/24.
//

import Foundation

public typealias GameCategory = CasinoCategory

public struct CasinoCategory: Codable, Hashable, JSONParsable {
    public let id: Int
    public let name: String
    public let slug: String
    public let dev_id: String?
}
