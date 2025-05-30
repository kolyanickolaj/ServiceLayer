//
//  ConfigRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/10/23.
//

import Foundation

final class ConfigRequest: BaseRequest, ModelRequest {

    typealias Model = String
    
    var path: String {
        "v2/configurations"
    }

    var payloadKey: String? {
        "data.countries"
    }
}
