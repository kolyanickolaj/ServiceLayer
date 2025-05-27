//
//  BasicAuthClient.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/28/23.
//

import Foundation

final class BasicAuthClient: URLSessionResourceInterceptor {
    
//    private let login: String, pass: String
//
//    init(login: String, pass: String) {
//        self.login = login
//        self.pass = pass
//    }
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
}

// MARK: - URLRequestAuthenticator

extension BasicAuthClient: URLRequestAuthenticator {
    
    @discardableResult
    func authenticateRequest(_ request: URLRequest, handler: @escaping AuthenticationHandler) -> Cancelable {
        var request = request
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "Basic \(token)"
        request.allHTTPHeaderFields = headers
        return handler(.success(request))
    }

    func evaluateFailedRequest(
        _ request: URLRequest,
        data: Data?,
        response: URLResponse?,
        error: Error,
        retryState: Retry.State
    ) -> Retry.Action {
        // here we could intercept authentication errors (e.g. 401 Unauthorized) and trigger a reauthentication, while
        // instructing the resource to be retried accordingly (e.g. after a certain amount of time), or not (e.g. user
        // is logged out)
        return .none
    }
}
