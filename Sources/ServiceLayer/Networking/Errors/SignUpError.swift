//
//  SignUpError.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/26/23.
//

import Foundation

struct SignUpError: Error {
    let code: Int
    let message: String
    let messages: [String]
    let fieldsAttributes: [Field]
    
    struct Field {
        let name: String
        let message: String
    }
}

// MARK: - LocalizedError

extension SignUpError: LocalizedError {
    
    var errorDescription: String? {
        if !messages.isEmpty {
            return messages.joined(separator: "\n")
        } else if !fieldsAttributes.isEmpty {
            return fieldsAttributes.map { "\($0.name): \($0.message)" }.joined(separator: "\n")
        }
        
        return message
    }
}
