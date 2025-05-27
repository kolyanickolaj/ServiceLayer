//
//  File.swift
//  
//
//  Created by Alexandr Gaidukov on 08.12.2019.
//

import Foundation

struct NotNilValidator<Value>: Validator {
    var errorMessage: String

    func validate(value: Value?) throws {
        if value == nil {
            throw ValidationError(message: errorMessage)
        }
    }
}
