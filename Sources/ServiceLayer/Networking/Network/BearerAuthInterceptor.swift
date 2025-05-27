//
//  BearerAuthInterceptor.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/13/23.
//

import Foundation

final class BearerAuthInterceptor: URLSessionResourceInterceptor {
    
    private let authorizationProvider: IAuthorizationProvider
    
    init(authorizationProvider: IAuthorizationProvider) {
        self.authorizationProvider = authorizationProvider
    }
}

// MARK: - URLRequestAuthenticator

extension BearerAuthInterceptor: URLRequestAuthenticator {
    
    @discardableResult
    func authenticateRequest(_ request: URLRequest, handler: @escaping AuthenticationHandler) -> Cancelable {
        var request = request
        guard let token = authorizationProvider.accessToken else {
            return handler(.success(request))
        }
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return handler(.success(request))
    }

    func evaluateFailedRequest(
        _ request: URLRequest,
        data: Data?,
        response: URLResponse?,
        error: Error,
        retryState: Retry.State
    ) -> Retry.Action {
        /*
         here we could intercept authentication errors (e.g. 401 Unauthorized) and trigger a reauthentication, while
         instructing the resource to be retried accordingly (e.g. after a certain amount of time), or not (e.g. user is logged out)
         */
        if let code = (error as? Network.URLSessionError)?.statusCode, code == .clientError(401) {
            authorizationProvider.logout()
        }
        return .none
    }
}
