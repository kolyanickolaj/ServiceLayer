//
//  UnauthorizedError.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation

struct UnauthorizedError: Decodable, Error, LocalizedError {
    let messages: [String]
    
    var errorDescription: String? { messages.joined(separator: "\n") }
}
