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

protocol IProfileService: AnyObject {

    func paymentSession() -> AnyPublisher<PaymentSessionRequest.Model, Error>
    func getProfile() -> AnyPublisher<Profile, Error>
    func cachedProfile() -> (isValid: Bool, Profile?)
    func subscribe() -> ObservingPublisher<Profile?>
}

final class ProfileService: IProfileService {

    private let profilePublisher = ObservingSubject<Profile?>()

    // Dependecies
    private let requester: Requester
    private let storage: IStorage
    private let authProvider: IAuthorizationProvider

    // MARK: - Inits

    init(requester: Requester, authProvider: IAuthorizationProvider, storage: IStorage) {
        self.requester = requester
        self.authProvider = authProvider
        self.storage = storage
    }

    // MARK: - IProfileService
    
    func subscribe() -> ObservingPublisher<Profile?> {
        return profilePublisher.eraseToAnyPublisher()
    }
    
    func paymentSession() -> AnyPublisher<PaymentSessionRequest.Model, Error> {
        let request = PaymentSessionRequest(method: .paymentSessionDepositMethod)
        return requester.fetch(request: request)
    }
    
    func getProfile() -> AnyPublisher<Profile, Error> {
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
    
    func cachedProfile() -> (isValid: Bool, Profile?) {
        guard authProvider.isAuthorized else {
            return (false, nil)
        }
        
        guard let dataObject = storage.fetch(DataObject.self, identifier: .cachedProfileKey),
              let cached: Profile = JSONToDataConverter.convert(data: dataObject.data) else {
            return (false, nil)
        }
        return (true, cached)
    }
}
