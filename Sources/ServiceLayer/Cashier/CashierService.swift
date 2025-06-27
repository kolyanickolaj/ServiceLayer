//
//  CashierService.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Combine

public protocol CashierServiceProtocol {
    func getPaymentMethods() -> AnyPublisher<[PaymentMethod], Error>
}

public final class CashierService: CashierServiceProtocol {
    private let requester: Requester
//    private let storage: IStorage
//    private let authProvider: IAuthorizationProvider

    public init(
        requester: Requester,
//        authProvider: IAuthorizationProvider,
//        storage: IStorage
    ) {
        self.requester = requester
//        self.authProvider = authProvider
//        self.storage = storage
    }
    
    public func getPaymentMethods() -> AnyPublisher<[PaymentMethod], Error> {
        let request = GetPaymentMethodsRequest()
        return requester.fetchList(request: request)
    }
}
