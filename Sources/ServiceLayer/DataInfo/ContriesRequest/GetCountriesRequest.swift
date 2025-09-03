//
//  GetCountriesRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/7/23.
//

import Foundation

final class GetCountriesRequest: BaseRequest, ModelRequest {

    typealias Model = Country
    
    var apiVersion: ApiVersion {
        .api
    }
    
    var path: String {
        "data/get-countries-list"
    }

    var payloadKey: String? {
        "data.countries"
    }
}
