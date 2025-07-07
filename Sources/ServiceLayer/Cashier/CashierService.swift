//
//  CashierService.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Combine

public protocol CashierServiceProtocol {
    func getPaymentMethods() -> AnyPublisher<PaymentSessionInfo, Error>
    func getDepositBonuses() -> AnyPublisher<[DepositBonus], Error>
}

public final class CashierService: CashierServiceProtocol {
    private let requester: Requester

    public init(
        requester: Requester
    ) {
        self.requester = requester
    }
    
    public func getPaymentMethods() -> AnyPublisher<PaymentSessionInfo, Error> {
        let request = GetPaymentMethodsRequest()
        return requester.fetch(request: request)
    }
    
    public func getDepositBonuses() -> AnyPublisher<[DepositBonus], Error> {
        let request = DepositBonusesRequest()
        return requester.fetchList(request: request)
    }
}
