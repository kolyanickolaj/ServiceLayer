//
//  BasicAuthTokenProvider.swift
//  Tonybet
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation

public final class BasicAuthTokenProvider: IBasicAuthTokenProvider {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
