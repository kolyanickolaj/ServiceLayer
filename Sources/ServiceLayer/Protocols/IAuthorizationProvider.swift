//
//  IAuthorizationProvider.swift
//  ServiceLayer
//
//  Created by Andrey Polyashev on 2/29/24.
//

import Foundation
import Combine

public protocol IAuthorizationProvider: AnyObject {
    var isAuthorized: Bool { get }
    var accessToken: String? { get }
    var authorizationPublisher: any Publisher<Bool, Never> { get }
    
    func saveToken(_ token: String)
    func logout()
}
