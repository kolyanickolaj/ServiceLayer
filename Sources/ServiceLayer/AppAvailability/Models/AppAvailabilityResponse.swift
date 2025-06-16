//
//  AppAvailabilityResponse.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 16.06.25.
//

public struct AppAvailabilityResponse: Codable, JSONParsable {
    public let isCountryAllowed: Bool
    public let message: String?
}
