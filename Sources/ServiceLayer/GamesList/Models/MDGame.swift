//
//  MDGame.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

public struct MDGame: Codable, Hashable, Equatable, Identifiable {
    public let id: Int
    public let title, identifier, identifier2: String
    public let producerID: Int
    public let producer: Producer
    public let isMobile: Int
    public let images: [String: MDGame.Image]?
    public let isFavorite: Bool
//    let casinoCategories: [CasinoCategory]
    public let categories: [String]
    public let category: String
    enum CodingKeys: String, CodingKey {
        case id, title, identifier, identifier2, isFavorite
        case producerID = "producer_id"
        case producer
        case isMobile = "is_mobile"
        case images
        case categories, category
    }
    
    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: - Equatable
    
    public static func == (lhs: MDGame, rhs: MDGame) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MDGame {
    public struct Image: Codable {
        let jpeg: URL?
        let webp: URL?
        let png: URL?
    }
    
    public enum PurpleCategory: String, Codable {
        case crash
        case slots
        case lottery
        case unknowed
        
        public init(rawValue: String) {
            switch rawValue {
            case "crash":
                self = .crash
            case "slots":
                self = .slots
            case "lottery":
                self = .lottery
            default:
                self = .unknowed
            }
        }
    }
}
