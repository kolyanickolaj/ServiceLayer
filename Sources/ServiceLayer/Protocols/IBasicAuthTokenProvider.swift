//
//  IBasicAuthTokenProvider.swift
//  ServiceLayer
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation

public protocol IBasicAuthTokenProvider {
    var token: String { get }
}
