// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

protocol ModuleConstants {
    var platformHost: URL { get }
    var host: URL { get }
    var userAgent: String { get }
}

enum ServiceLayer {
    static var constants: ModuleConstants!
    
    static func configure(_ constants: ModuleConstants) {
        self.constants = constants
    }
}
