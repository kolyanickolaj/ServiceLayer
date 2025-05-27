//
//  Formatter.swift
//  Tonywin
//
//  Created by Andrey on 7/31/23.
//

import Foundation

private enum TimeZones {
    static let gmt_3 = "Europe/London"
}

extension Formatter {
    static var customISO8601DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static var dateForDrawTimer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: TimeZones.gmt_3)
        return formatter
    }()
    
    static var dateForDrawLabel: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    static var dateForDrawInfo: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        return formatter
    }()
}
