//
//  ParsingErrors.swift
//  CasinoBrand
//
//  Created by Andrey on 10/27/22.
//

import Foundation

enum ParsingErrors: Error, LocalizedError {
    case payloadParsingError
    
    var errorDescription: String? {
        return Localization.cantDecodeResponse.localized
    }
}
