//
//  SignUpRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/26/23.
//

import Foundation

extension SignUpRequest {
    public struct Query: Codable {
        public let name: String
        public let surname: String
        public let gender: Int
        public let email: String
        public let password: String
        public let country: String
        public let prefix: String
        public let phone: String
        public let dob: String
        public let acceptPolicy: Bool
        public let recaptcha: String
        public let currency: String
        public let city: String
        public let street: String
        public let postcode: String
        public let provinceId: Int?
        public let btag : String?
        public let clickId : String?
        public let tracking: Tracking
    }
}

public struct Tracking: Codable {
    let subid: String?
}
