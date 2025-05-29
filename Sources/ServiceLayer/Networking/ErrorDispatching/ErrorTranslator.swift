//
//  ErrorTranslator.swift
//  ServiceLayer
//
//  Created by Nikolai Lipski on 29.05.25.
//

import Foundation

public final class ErrorTranslator: ErrorModifying {
    let translationsProvider: Translations
    
    public init(translationsProvider: Translations) {
        self.translationsProvider = translationsProvider
    }
    
    func extract(remoteData: Data?) -> Error? {
        nil
    }
    
    public func modify(error: Error) -> Error? {
        let translation = translationsProvider
        switch error {
        case let error as UnauthorizedError:
            return UnauthorizedError(messages: error.messages.map { translation[$0] ?? $0 })
        case let error as ClientError:
            return ClientError(message: error.message.map { translation[$0] ?? $0 })
        case let error as LoginError:
            return LoginError(
                apiCode: error.apiCode,
                networkCode: error.networkCode,
                messages: error.messages.map {
                    var value = (translation[$0] ?? $0)
                    error.attributes.forEach {
                        value = value.replacingOccurrences(of: $0.key, with: $0.value)
                        value = value.replacingOccurrences(of: "%", with: "")
                    }
                    return value
                },
                attributes: error.attributes
            )
        case let error as SignUpError:
            return SignUpError(
                code: error.code,
                message: translation[error.message] ?? error.message,
                messages: error.messages.map { translation[$0] ?? $0 },
                fieldsAttributes: error.fieldsAttributes.map {
                    .init(
                        name: translation[$0.name] ?? $0.name,
                        message: translation[$0.message] ?? $0.message
                    )
                }
            )
        default:
            return error
        }
    }
}
