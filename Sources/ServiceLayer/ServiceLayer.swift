// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol ModuleConstants {
    var platformHost: URL { get }
    var host: URL { get }
    var userAgent: String { get }
}

public enum ServiceLayer {
    static var constants: ModuleConstants!
    
    public static func configure(_ constants: ModuleConstants) {
        self.constants = constants
    }
    
    public static var isConfigured: Bool {
        self.constants != nil
    }
}
