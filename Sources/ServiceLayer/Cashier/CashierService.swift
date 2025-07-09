//
//  CashierService.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 26.06.25.
//

import Combine

public protocol CashierServiceProtocol {
    func getDepositMethods() -> AnyPublisher<PaymentSessionInfo, Error>
    func getWithdrawalMethods() -> AnyPublisher<PaymentSessionInfo, Error>
    func getDepositBonuses() -> AnyPublisher<[DepositBonus], Error>
}

public final class CashierService: CashierServiceProtocol {
    private let requester: Requester

    public init(
        requester: Requester
    ) {
        self.requester = requester
    }
    
    public func getDepositMethods() -> AnyPublisher<PaymentSessionInfo, Error> {
        let request = GetPaymentMethodsRequest(operation: .deposit)
        return requester.fetch(request: request)
    }
    
    public func getWithdrawalMethods() -> AnyPublisher<PaymentSessionInfo, Error> {
        let request = GetPaymentMethodsRequest(operation: .withdrawal)
        return requester.fetch(request: request)
    }
    
    public func getDepositBonuses() -> AnyPublisher<[DepositBonus], Error> {
        let request = DepositBonusesRequest()
        return requester.fetchList(request: request)
    }
}
