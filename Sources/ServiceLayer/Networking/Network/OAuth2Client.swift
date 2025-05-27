//
//  OAuth2Client.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

class OAuth2Client: URLSessionResourceInterceptor {

    typealias OAuth2Token = String
/*
    class M: Cancelable {
        var isCancelled: Bool = false
        
        func cancel() {
            
        }
    }
    
    // example async API to fetch the current OAuth2 token, or wait for one to be fetched
    func token(for request: URLRequest, completion: (Result<OAuth2Token, Error>) -> Void) -> Cancelable {
        completion(.success("token"))
        return M()
    }
 */
}

extension OAuth2Client: URLRequestAuthenticator {

//    @discardableResult
//    func authenticateRequest(_ request: URLRequest, handler: @escaping AuthenticationHandler) -> Cancelable {
//
//        let cancelableBag = CancelableBag()
//
//        // the client is responsible for providing the current token (if any), which it then injects on the request
//        // ideally this should be made asynchronously so it doesn't block the network stack
//        cancelableBag += token(for: request) { result in
//
//            switch result {
//            case .failure(let error):
//                // something went wrong, and the request can't be authenticated
//                cancelableBag += handler(.failure(error))
//
//            case .success(let token):
//                // the request can be authenticated with the given token
//                var request = request
//
//                var httpHeaders = request.allHTTPHeaderFields ?? [:]
//                httpHeaders["Authorization"] = "token \(token)"
//                request.allHTTPHeaderFields = httpHeaders
//
//                cancelableBag += handler(.success(request))
//            }
//        }
//
//        var request = request
//
//        var httpHeaders = request.allHTTPHeaderFields ?? [:]
//        httpHeaders["Authorization"] = "token \("token")"
//        request.allHTTPHeaderFields = httpHeaders
//
//        cancelableBag += handler(.success(request))
//
//
//        return cancelableBag
//    }

    @discardableResult
    func authenticateRequest(_ request: URLRequest, handler: @escaping AuthenticationHandler) -> Cancelable {

        let cancelableBag = CancelableBag()

        var request = request

        var httpHeaders = request.allHTTPHeaderFields ?? [:]
        #warning("add authorization")
//        httpHeaders["Authorization"] = "token \("token")"
        request.allHTTPHeaderFields = httpHeaders

        cancelableBag += handler(.success(request))

        return cancelableBag
    }

    func evaluateFailedRequest(
        _ request: URLRequest,
        data: Data?,
        response: URLResponse?,
        error: Error,
        retryState: Retry.State
    ) -> Retry.Action {

        // extract the token used by the failed request (if any)
        let rawToken = request.allHTTPHeaderFields?["Authorization"]
        let oAuthToken = rawToken?.split(separator: " ").last.flatMap(String.init)

        // handle the request's error and evaluate the action to take according to the current authentication state:
        // - trigger a (re)auth behind the scenes, and retry the request after some delay
        // - ignore the error as the token has already been refreshed, and retry the request
        // - mandate that the request should not be retried, as authentication failed
        // - ignore the error as the error is not related to authentication
        return .none
//
//        switch (error, self.state) {
//        case ...:
//        default:
//            return .none
//        }
    }
}
