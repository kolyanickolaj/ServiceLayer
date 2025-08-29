//
//  Document.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 29.08.25.
//

public struct Document: Codable, JSONParsable {
    public let id: Int
    public let status: VerificationStatus
    public let imageName: String
    public let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id, status
        case imageName = "uploadName"
        case imageUrl = "url"
    }
}
