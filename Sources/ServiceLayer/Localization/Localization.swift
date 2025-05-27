//
//  Localization.swift
//  ServiceLayer
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation

enum Localization: String {
    case ok
    case defaultErrorTitle
    case cantDecodeResponse
    case somethingWentWrongError
    case authRequired
    case cantFindHost
    case resourceUnavailable
    case internetConnectionLost
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
