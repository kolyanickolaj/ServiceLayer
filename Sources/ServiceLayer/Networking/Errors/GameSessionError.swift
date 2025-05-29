//
//  GameSessionError.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/21/24.
//

import Foundation

struct GameSessionError: Error, Codable, LocalizedError {
    let status: String
    let data: String
    let message: String
    
    var errorDescription: String? { return message }
}
