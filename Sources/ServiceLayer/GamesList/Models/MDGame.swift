//
//  MDGame.swift
//  CasinoTool
//
//  Created by Andrey Polyashev on 9/28/22.
//

import Foundation

struct MDGame: Codable, Hashable, Equatable, Identifiable {
    let id: Int
    let title, identifier, identifier2: String
    let producerID: Int
    let producer: Producer
    let isMobile: Int
    let images: [String: MDGame.Image]?
//    let casinoCategories: [CasinoCategory]
    let categories: [String]
    let category: String
    enum CodingKeys: String, CodingKey {
        case id, title, identifier, identifier2
        case producerID = "producer_id"
        case producer
        case isMobile = "is_mobile"
        case images
        case categories, category
    }
    
    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: - Equatable
    
    static func == (lhs: MDGame, rhs: MDGame) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MDGame {
        
    struct Image: Codable {
        let jpeg: URL?
        let webp: URL?
        let png: URL?
    }
    
    enum PurpleCategory: String, Codable {
        case crash
        case slots
        case lottery
        case unknowed
        
        init(rawValue: String) {
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
