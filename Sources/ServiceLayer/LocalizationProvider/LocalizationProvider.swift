//
//  LocalizationProvider.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 21.11.2023.
//

import Foundation

protocol ILocalizationProvider {
    
    func getPreferredLanguage() -> Language
}

final class LocalizationProvider: ILocalizationProvider {
    
    func getPreferredLanguage() -> Language {
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return .en
        }
        return .init(rawValue: preferredLanguage) ?? .en
    }
}
