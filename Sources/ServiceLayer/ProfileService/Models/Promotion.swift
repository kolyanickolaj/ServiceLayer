//
//  Promotion.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 5.07.25.
//

import Foundation

public struct Promotion: Codable, JSONParsable {
    public var id: Int
    public var title: String
    public var description: String?
    public var term: String?
    public var imageData: ImageData
    public var backgroundImageData: ImageData
    public var foregroundImageData: ImageData
}
