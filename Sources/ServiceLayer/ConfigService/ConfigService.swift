//
//  ConfigService.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/10/23.
//

import Foundation
import Combine

private extension String {
    static let translationsKey = "translationsKey"
}

public protocol IConfigService: AnyObject {
    func getConfig() -> AnyPublisher<[String], Error>
    func getTranslation(locale: String?) -> AnyPublisher<Translations, Error>
    func cachedTranslations() -> (isValid: Bool, Translations)
}

public final class ConfigService: IConfigService {
    // Dependecies
    private let requester: Requester
    private let storage: IStorage

    // MARK: - Inits

    public init(
        requester: Requester,
        storage: IStorage
    ) {
        self.requester = requester
        self.storage = storage
    }

    // MARK: - IDataInfoService

    public func getConfig() -> AnyPublisher<[String], Error> {
        let request = ConfigRequest()
        return requester.fetchList(request: request)
    }

    public func getTranslation(locale: String?) -> AnyPublisher<Translations, Error> {
        let request = TranslationRequest(locale: locale)
        return requester.fetch(request: request)
            .handleEvents(receiveOutput: { [weak self] translations in
                guard let data = try? translations.dict.rawData() else {
                    return
                }
                let model = DataObject(identifier: .translationsKey, data: data)
                self?.storage.save(model: model)
            })
            .share()
            .eraseToAnyPublisher()
    }
    
    public func cachedTranslations() -> (isValid: Bool, Translations) {
        guard let dataObject = storage.fetch(DataObject.self, identifier: .translationsKey),
              let cached: Translations = JSONToDataConverter.convert(data: dataObject.data) else {
            return (false, defaultTranslations())
        }
        return (true, cached)
    }
    
    func defaultTranslations() -> Translations {
        .init()
    }
}
