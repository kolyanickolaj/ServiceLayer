//
//  ProvincesRequest.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//

import Foundation

final class ProvincesRequest: BaseRequest {
    
    var apiVersion: ApiVersion {
        .api
    }
    
    var path: String? {
        "data/provinces"
    }
    
    var queryItems: [URLQueryItem]? {
        var queries: [URLQueryItem] = []
        if let country {
            queries.append(.init(name: "countryAlpha2Code", value: country))
        }
        return queries
    }
    
    private let country: String?
    
    init(country: String?) {
        self.country = country
    }
}
