//
//  LocalizationProvider.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 21.11.2023.
//

import Foundation

public protocol ILocalizationProvider {
    func getPreferredLanguage() -> Language
}

public final class LocalizationProvider: ILocalizationProvider {
    public init() {}
    
    public func getPreferredLanguage() -> Language {
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return .en
        }
        return .init(rawValue: preferredLanguage) ?? .en
    }
}
