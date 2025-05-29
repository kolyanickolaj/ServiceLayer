//
//  KeychainStorage+AccessTokenStorage.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 11/15/23.
//

import Foundation

public protocol AccessTokenStorage: AnyObject {
    typealias JWT = String
    var accessToken: JWT? { get set }
}

extension KeychainStorage: AccessTokenStorage {
    public var accessToken: JWT? {
        get {
            try? getAccessToken()
        }
        set {
            if let token = newValue {
                try? saveAccessToken(token)
            } else {
                try? deleteAccessToken()
            }
        }
    }
}
