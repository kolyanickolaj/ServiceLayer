//
//  Countries.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation
import Combine

public protocol IDataInfoService: AnyObject {
    func getCountries() -> AnyPublisher<[Country], Error>
    func getCurrencies() -> AnyPublisher<[Currency], Error>
    func getProvinces(country: String?) -> AnyPublisher<[Province], Error>
}

public final class DataInfoService: IDataInfoService {
    private let requester: Requester

    public init(
        requester: Requester
    ) {
        self.requester = requester
    }
    
    public func getCountries() -> AnyPublisher<[Country], Error> {
        let request = GetCountriesRequest()
        return requester.fetchList(request: request)
    }
    
    public func getCurrencies() -> AnyPublisher<[Currency], Error> {
        let request = CurrenciesRequest()
        return requester.fetchList(request: request)
    }
    
    public func getProvinces(country: String?) -> AnyPublisher<[Province], Error> {
        let request = ProvincesRequest(country: country)
        return requester.fetchList(request: request)
    }
}
