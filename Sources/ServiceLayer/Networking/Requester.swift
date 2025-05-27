//
//  Requester.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation
import Combine
import OSLog

public final class Requester {

    private let network: Network.URLSessionNetworkStack
    private let authorizationProvider: IAuthorizationProvider
    private let basicAuthTokenProvider: IBasicAuthTokenProvider
    
    public init(
        network: Network.URLSessionNetworkStack,
        authorizationProvider: IAuthorizationProvider,
        basicAuthTokenProvider: IBasicAuthTokenProvider
    ) {
        self.network = network
        self.authorizationProvider = authorizationProvider
        self.network.session = URLSession(configuration: .default, delegate: network, delegateQueue: nil)
        self.basicAuthTokenProvider = basicAuthTokenProvider
    }
    
    public func fetch<Request: ModelRequest, Model>(request: Request) -> AnyPublisher<Model, Error> where Model == Request.Model {
        let interceptors = interceptors(for: request)
        return Future<Model, Error> { [weak self] promis in
            let completion: (Result<Model, Error>) -> Void = { result in
                switch result {
                case .success(let success):
                    promis(.success(success))
                case .failure(let failure):
                    promis(.failure(failure))
                }
            }
            
            self?.network.fetch(
                request: request,
                interceptors: interceptors,
                completion: completion
            )
        }.eraseToAnyPublisher()
    }
    
    public func fetchList<Request: ModelRequest, Model>(request: Request) -> AnyPublisher<[Model], Error> where Model == Request.Model {
        let interceptors = interceptors(for: request)
        return Future<[Model], Error> { [weak self] promis in
            let completion: (Result<[Model], Error>) -> Void = { result in
                switch result {
                case .success(let success):
                    promis(.success(success))
                case .failure(let failure):
                    promis(.failure(failure))
                }
            }
            
            self?.network.fetchList(
                request: request,
                interceptors: interceptors,
                completion: completion
            )
        }.eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private func interceptors(for request: RequestResource) -> [URLSessionResourceInterceptor] {
        let interceptors: [URLSessionResourceInterceptor]
        switch request.zone {
        case .public:
            interceptors = []
        case .private:
            interceptors = [BearerAuthInterceptor(authorizationProvider: authorizationProvider)]
        case .privateCms:
            interceptors = [BasicAuthClient(token: basicAuthTokenProvider.token)]
        }
        return interceptors
    }
}
