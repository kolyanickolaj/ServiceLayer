//
//  AuthorizationService.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/21/23.
//

import Foundation
import Combine

public final class AuthorizationProvider: IAuthorizationProvider {
    
    // Public
    public var isAuthorized: Bool {
        storage.accessToken != nil
    }
    
    public var accessToken: String? {
        storage.accessToken
    }
    
    public var authorizationPublisher: any Publisher<Bool, Never> {
        authorizationSubject
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
    }
    
    // Private
    private let authorizationSubject = PassthroughSubject<Bool, Never>()
    private let storage: AccessTokenStorage
    
    // MARK: - Inits
    
    public init(storage: AccessTokenStorage) {
        self.storage = storage
    }
    
    // MARK: - IAuthorizationProvider
    
    public func saveToken(_ token: String) {
        storage.accessToken = token
        authorizationSubject.send(true)
    }
    
    public func logout() {
        storage.accessToken = nil
        authorizationSubject.send(false)
    }
}
