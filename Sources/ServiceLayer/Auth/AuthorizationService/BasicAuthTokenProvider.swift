//
//  BasicAuthTokenProvider.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation

final class BasicAuthTokenProvider: IBasicAuthTokenProvider {
    
    let token: String
    
    init(token: String) {
        self.token = token
    }
}
