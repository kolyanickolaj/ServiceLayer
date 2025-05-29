//
//  ServerErrors.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation

enum ServerErrors: Int, LocalizedError {
    case serviceUnavailable = 503
    
    var errorDescription: String? {
        switch self {
        case .serviceUnavailable:
            return Localization.serviceUnavailable.localized
        }
    }
}
