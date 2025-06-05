//
//  ImageUrl.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 27.05.25.
//

import Foundation

public struct ImageUrl: Codable {
    public let square: URL
    public let rectangle: URL
}
