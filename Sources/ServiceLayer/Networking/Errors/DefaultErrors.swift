//
//  DefaultErrors.swift
//  ServiceLayer
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation

public enum DefaultErrors: LocalizedError {
    case somethingWentWrong
    case custom(text: String?)
    case unsuccessfullyCode
    case unexpectedResponse(Error?)
    case decodeModelFailed
    
    public var errorDescription: String? {
        switch self {
        case .somethingWentWrong:
            return "Something went wrong"
        case .unexpectedResponse, .unsuccessfullyCode, .decodeModelFailed:
            return "Unexpected response"
        case .custom(let text):
            return text
        }
    }
}
