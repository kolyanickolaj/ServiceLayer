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
        public let gender: Int?
        public let email: String
        public let password: String
        public let country: String
        public let prefix: String?
        public let phone: String?
        public let dob: String?
        public let acceptPolicy: Bool
        public let recaptcha: String
        public let currency: String
        public let city: String?
        public let street: String?
        public let postcode: String?
        public let provinceId: Int?
        public let btag : String?
        public let clickId : String?
        public let tracking: Tracking
        
        public init(name: String, surname: String, gender: Int?, email: String, password: String, country: String, prefix: String?, phone: String?, dob: String?, acceptPolicy: Bool, recaptcha: String, currency: String, city: String?, street: String?, postcode: String?, provinceId: Int?, btag: String?, clickId: String?, tracking: Tracking) {
            self.name = name
            self.surname = surname
            self.gender = gender
            self.email = email
            self.password = password
            self.country = country
            self.prefix = prefix
            self.phone = phone
            self.dob = dob
            self.acceptPolicy = acceptPolicy
            self.recaptcha = recaptcha
            self.currency = currency
            self.city = city
            self.street = street
            self.postcode = postcode
            self.provinceId = provinceId
            self.btag = btag
            self.clickId = clickId
            self.tracking = tracking
        }
    }
}

public struct Tracking: Codable {
    public let subid: String?
    
    public init(subid: String?) {
        self.subid = subid
    }
}
