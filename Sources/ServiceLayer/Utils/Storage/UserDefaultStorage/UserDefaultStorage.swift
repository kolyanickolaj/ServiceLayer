//
//  UserDefaultStorage.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 31.01.2024.
//

import Foundation
import OSLog

public protocol IUserDefaultStorage {
    func value<T: Decodable>(for key: String) -> T?
    func setValue<T: Codable>(value: T, for key: String)
}

public final class UserDefaultStorage: IUserDefaultStorage {
    public init() {}
    
    private let userDefaults = UserDefaults.standard
    
    public func value<T: Decodable>(for key: String) -> T? {
        let data = userDefaults.data(forKey: key)
        let value = data.flatMap { try? JSONDecoder().decode(T.self, from: $0) }
        return value
    }
    
    public func setValue<T: Codable>(value: T, for key: String) {
        let data = try? JSONEncoder().encode(value)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
}
