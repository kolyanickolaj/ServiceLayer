//
//  Countries.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation
import Combine

private extension String {
    static let countriesCacheId = "countriesCacheId"
}

protocol IDataInfoService: AnyObject {
    func cachedCountries() -> (isValid: Bool, [Country])
    func getCountries() -> AnyPublisher<[Country], Error>
    func getCurrencies() -> AnyPublisher<[CurrenciesRequest.Model], Error>
    func getProvinces(country: String?) -> AnyPublisher<[ProvincesRequest.Model], Error>
}

final class DataInfoService: IDataInfoService {

    // Dependecies
    private let requester: Requester
    private let storage: StorageAuthoinjection

    // MARK: - Inits

    init(requester: Requester, storage: @escaping StorageAuthoinjection) {
        self.requester = requester
        self.storage = storage
    }

    // MARK: - IDataInfoService

    func getCountries() -> AnyPublisher<[Country], Error> {
        let request = GetCountriesRequest()
        return requester.fetchList(request: request)
            .handleEvents(receiveOutput: { [weak self] countries in
                guard let data = JSONToDataConverter.convert(model: countries) else {
                    return
                }
                let model = DataObject(identifier: .countriesCacheId, data: data)
                self?.storage()?.save(model: model)
            })
            .share()
            .eraseToAnyPublisher()
    }
    
    func getCurrencies() -> AnyPublisher<[CurrenciesRequest.Model], Error> {
        let request = CurrenciesRequest()
        return requester.fetchList(request: request)
    }
    
    func getProvinces(country: String?) -> AnyPublisher<[ProvincesRequest.Model], Error> {
        let request = ProvincesRequest(country: country)
        return requester.fetchList(request: request)
    }
    
    func cachedCountries() -> (isValid: Bool, [Country]) {
        guard let dataObject = storage()?.fetch(DataObject.self, identifier: .countriesCacheId),
              let cached: [Country] = JSONToDataConverter.convert(data: dataObject.data) else {
            return (false, [])
        }
        
        let isValid = (Date().timeIntervalSince1970 - dataObject.timestamp) < .cacheLifetime1Day
        return (isValid, cached)
    }
}
