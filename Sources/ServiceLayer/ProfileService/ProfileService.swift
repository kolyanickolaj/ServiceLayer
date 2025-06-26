//
//  ProfileService.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation
import Combine

private extension String {
    static let cachedProfileKey = "cachedProfileKey"
    static let paymentSessionDepositMethod = "deposit"
}

public protocol IProfileService: AnyObject {
    func paymentSession() -> AnyPublisher<PaymentSessionRequest.Model, Error>
    func getProfile() -> AnyPublisher<Profile, Error>
    func cachedProfile() -> (isValid: Bool, profile: Profile?)
    func subscribe() -> ObservingPublisher<Profile?>
    func getBonuses() -> AnyPublisher<[Bonus], Error>
    func getPreferences() -> AnyPublisher<NotificationPreferences, Error>
    func savePreferences(_ prefs: NotificationPreferences) -> AnyPublisher<SavePreferencesResponse, Error>
}

public final class ProfileService: IProfileService {
    private let profilePublisher = ObservingSubject<Profile?>()

    // Dependecies
    private let requester: Requester
    private let storage: IStorage
    private let authProvider: IAuthorizationProvider

    // MARK: - Inits

    public init(
        requester: Requester,
        authProvider: IAuthorizationProvider,
        storage: IStorage
    ) {
        self.requester = requester
        self.authProvider = authProvider
        self.storage = storage
    }

    // MARK: - IProfileService
    
    public func subscribe() -> ObservingPublisher<Profile?> {
        profilePublisher.eraseToAnyPublisher()
    }
    
    public func paymentSession() -> AnyPublisher<PaymentSession, Error> {
        let request = PaymentSessionRequest(method: .paymentSessionDepositMethod)
        return requester.fetch(request: request)
    }
    
    public func getProfile() -> AnyPublisher<Profile, Error> {
        let request = ProfileRequest()
        return requester.fetch(request: request)
            .handleEvents(receiveOutput: { [weak self] profile in
                self?.profilePublisher.send(profile)
                guard let data = try? JSONEncoder().encode(profile) else {
                    return
                }
                let model = DataObject(identifier: .cachedProfileKey, data: data)
                self?.storage.save(model: model)
            })
            .share()
            .eraseToAnyPublisher()
    }
    
    public func cachedProfile() -> (isValid: Bool, profile: Profile?) {
        guard authProvider.isAuthorized else {
            return (false, nil)
        }
        
        guard let dataObject = storage.fetch(DataObject.self, identifier: .cachedProfileKey),
              let cached: Profile = JSONToDataConverter.convert(data: dataObject.data) else {
            return (false, nil)
        }
        return (true, cached)
    }
    
    public func getBonuses() -> AnyPublisher<[Bonus], Error> {
        let request = BonusesRequest()
        return requester.fetchList(request: request)
    }
    
    public func getPreferences() -> AnyPublisher<NotificationPreferences, Error> {
        let request = GetPreferencesRequest()
        return requester.fetch(request: request)
    }
    
    public func savePreferences(_ prefs:NotificationPreferences) -> AnyPublisher<SavePreferencesResponse, Error> {
        let request = SavePreferencesRequest(
            queries: .init(
                isPhoneAllowed: prefs.isPhoneEnabled,
                isEmailAllowed: prefs.isEmailEnabled
            )
        )
        return requester.fetch(request: request)
    }
}
