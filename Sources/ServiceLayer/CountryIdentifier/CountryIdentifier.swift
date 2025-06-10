//
//  CountryIdentifier.swift
//  BetApp
//
//  Created by Nikolai Lipski on 6.05.25.
//

import Foundation

public protocol CountryIdentifierProtocol {
    func fetchUserCountry() async throws -> IPInfo
}

public final class CountryIdentifier: CountryIdentifierProtocol {
    public init() {}
    
    public func fetchUserCountry() async throws -> IPInfo {
        let url = URL(string: "https://ipapi.co/json/")!

        let (data, _) = try await URLSession.shared.data(from: url)
        let info = try JSONDecoder().decode(IPInfo.self, from: data)

        return info
    }
}

