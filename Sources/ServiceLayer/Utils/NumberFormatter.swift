//
//  NumberFormatter.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/5/23.
//

import Foundation

extension NumberFormatter {
    
    static var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.locale = .current
        return formatter
    }()
}
