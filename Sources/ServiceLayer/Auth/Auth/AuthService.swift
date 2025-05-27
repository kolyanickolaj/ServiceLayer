//
//  AuthService.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/4/23.
//

import Foundation
import Combine

protocol IAuthService: AnyObject {

    func signIn(login: String, pass: String, secondFactorCode: String?) -> AnyPublisher<AuthResponse, Error>

    func signUp(params: SignUpRequest.Params) -> AnyPublisher<SignUpResponseModel, Error>
    
    func resetPassword(email: String) -> AnyPublisher<ResetPasswordRequest.Model, Error>
    
    func validate(params: SignUpValidationRequest.PhoneQuery) -> AnyPublisher<SignUpValidationRequest.Model, Error>
}

final class AuthService: IAuthService {

    // Dependecies
    private let requester: Requester
    private let storage: IStorage

    // MARK: - Inits

    init(requester: Requester, storage: IStorage) {
        self.requester = requester
        self.storage = storage
    }

    func signIn(login: String, pass: String, secondFactorCode: String?) -> AnyPublisher<AuthResponse, Error> {
        let request = SignInRequest(queries: .init(email: login, password: pass, confirmationCode: secondFactorCode))
        return requester.fetch(request: request)
    }

    func signUp(params: SignUpRequest.Params) -> AnyPublisher<SignUpResponseModel, Error> {
        let request = SignUpRequest(params: params)
        return requester.fetch(request: request)
    }
    
    func validate(params: SignUpValidationRequest.PhoneQuery)
    -> AnyPublisher<SignUpValidationRequest.Model, Error> {
        let request = SignUpValidationRequest(queries: params)
        return requester.fetch(request: request)
    }
    
    func resetPassword(
        email: String
    ) -> AnyPublisher<ResetPasswordRequest.Model, Error> {
        let request = ResetPasswordRequest(queries: .init(type: 1, email: email))
        return requester.fetch(request: request)
    }
}
