//
//  CurrenciesRequest.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//


final class CurrenciesRequest: BaseRequest {
    
    var apiVersion: ApiVersion {
        .api
    }
    
    var path: String? {
        "data/get-currencies"
    }
}
