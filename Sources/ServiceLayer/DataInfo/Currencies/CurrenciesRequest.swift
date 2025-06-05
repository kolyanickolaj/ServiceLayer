//
//  CurrenciesRequest.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 3/5/24.
//


public final class CurrenciesRequest: BaseRequest {
    public var apiVersion: ApiVersion {
        .api
    }
    
    public var path: String? {
        "data/get-currencies"
    }
}
