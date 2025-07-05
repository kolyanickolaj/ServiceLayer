//
//  ImageData.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 5.07.25.
//

public struct ImageData: Codable, JSONParsable {
    public let webp: String?
    public let original: String?
}
