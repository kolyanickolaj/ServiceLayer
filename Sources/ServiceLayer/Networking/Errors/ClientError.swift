//
//  ClientError.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation

struct ClientError: Decodable, Error, LocalizedError {
    let message: [String]
    
    var errorDescription: String? { message.joined(separator: "\n") }
}
