//
//  SignUpRequest+Model.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/26/23.
//

import Foundation

extension SignUpRequest {

    struct Query: Codable {
        let name: String
        let surname: String
        let gender: Int
        let email: String
        let password: String
        let country: String
        let prefix: String
        let phone: String
        let dob: String
        let acceptPolicy: Bool
        let recaptcha: String
        let currency: String
        let city: String
        let street: String
        let postcode: String
        let provinceId: Int?
        let btag : String?
        let clickId : String?
        let tracking: Tracking
    }
}


//let nickname: String?
//let bonusType : Int
//let gender : Int
//let currency : String
//let prefix : String
//let country : String
//let email : String
//let promotion : Bool
//let password : String
//let phone : String
//let personalCode : String?
//let name : String
//let surname : String
//let dob : String
//let day : String
//let month : String
//let year : String
//let terms : Bool
//var recaptcha : String
//let btag : String?
//let ctag : String?
//let clickId : String?
//let utmCampaign : String?
//let utmContent : String?
//let utmMedium : String?
//let utmSource : String?
//let utmTerm : String?
//let langIso : String // en
//let localeIso : String // en

struct Tracking: Codable {
    let subid: String?
}
