//
//  AppAvailabilityService.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 16.06.25.
//

import Foundation
import Combine

public protocol AppAvailabilityProvider {
    func checkAppAvailability(for coordinates: Coordinates) -> AnyPublisher<AppAvailabilityResponse, Error>
}

public final class AppAvailabilityService: AppAvailabilityProvider {
    private let requester: Requester
    public init(
        requester: Requester
    ) {
        self.requester = requester
    }
    
    public func checkAppAvailability(for coordinates: Coordinates) -> AnyPublisher<AppAvailabilityResponse, Error> {
        let request = AppAvailabilityRequest(queries: .init(latitude: coordinates.latitude, longitude: coordinates.longitude))
        return requester.fetch(request: request)
    }
}
