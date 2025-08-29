//
//  VerificationStatus.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 29.08.25.
//

public enum VerificationStatus: Int, Codable, JSONParsable {
    case pending = 0
    case approved = 1
    case cancelled = 2
    case seen = 3
    
    enum CodingKeys: String, CodingKey {
        case pending = "PENDING"
        case approved = "APPROVED"
        case cancelled = "CANCELLED"
        case seen = "SEEN"
    }
}
