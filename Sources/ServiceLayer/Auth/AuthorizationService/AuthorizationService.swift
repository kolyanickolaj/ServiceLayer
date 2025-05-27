//
//  AuthorizationService.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/21/23.
//

import Foundation
import Combine

final class AuthorizationProvider: IAuthorizationProvider {
    
    // Public
    var isAuthorized: Bool {
        storage.accessToken != nil
    }
    
    var accessToken: String? {
        storage.accessToken
    }
    
    var authorizationPublisher: any Publisher<Bool, Never> {
        authorizationSubject
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
    }
    
    // Private
    private let authorizationSubject = PassthroughSubject<Bool, Never>()
    private let storage: AccessTokenStorage
    
    // MARK: - Inits
    
    init(storage: AccessTokenStorage) {
        self.storage = storage
        storage.accessToken = nil
    }
    
    // MARK: - IAuthorizationProvider
    
    func saveToken(_ token: String) {
        storage.accessToken = token
        authorizationSubject.send(true)
    }
    
    func logout() {
        storage.accessToken = nil
        authorizationSubject.send(false)
    }
}
