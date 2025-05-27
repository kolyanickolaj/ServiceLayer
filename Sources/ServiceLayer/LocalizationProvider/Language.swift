//
//  Language.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation

enum Language: String, CaseIterable {
    case en
    
    var title: String {
        switch self {
        case .en:
            return "English"
        }
    }
}
