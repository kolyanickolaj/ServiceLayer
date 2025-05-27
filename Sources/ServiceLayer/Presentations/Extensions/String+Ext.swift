//
//  String+Ext.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 26.12.2023.
//

import Foundation

extension String {
    
    public func applyPhoneNumberMask() -> String {
        let visibleDigitsCount = 4
        let lastVisiblePartLength = 2
        
        let hiddenPart = String(repeating: ".", count: self.count - lastVisiblePartLength)
        let visiblePart = String(self.suffix(lastVisiblePartLength))
        
        let maskedNumber = hiddenPart + visiblePart
        
        guard self.count > visibleDigitsCount else { return self }
        
        var formattedNumber = ""
        var remainingDigits = maskedNumber
        while remainingDigits.count > visibleDigitsCount + lastVisiblePartLength {
            let chunk = String(remainingDigits.prefix(3))
            formattedNumber += chunk + " "
            remainingDigits = String(remainingDigits.suffix(from: remainingDigits.index(remainingDigits.startIndex, offsetBy: 3)))
        }
        formattedNumber += String(remainingDigits.prefix(remainingDigits.count - lastVisiblePartLength)) + " "
        formattedNumber += String(remainingDigits.suffix(lastVisiblePartLength))
        
        return formattedNumber
    }
}

extension String {
    
    public func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
