//
//  TranslationRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/10/23.
//

import Foundation

final class TranslationRequest: BaseRequest, ModelRequest {

    typealias Model = Translations
    
    private let locale: String?

    var zone: RequestZone {
        .privateCms
    }
    
    var method: HTTP.Method {
        .GET
    }

    var path: String? {
        "translation/get"
    }
    
    var apiVersion: ApiVersion {
        .api
    }

    var payloadKey: String? {
        "data"
    }
    
    var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        if let locale {
            queries.append(.init(name: "locale", value: locale))
        }
        return queries
    }
    
    init(locale: String?) {
        self.locale = locale
    }
}
