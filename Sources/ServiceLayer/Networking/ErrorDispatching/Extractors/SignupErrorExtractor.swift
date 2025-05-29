//
//  SignupErrorExtractor.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation
import SwiftyJSON

public final class SignupErrorExtractor: ErrorExtracting {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    public func extract(
        request: RequestResource,
        error: Error?
    ) -> Error? {
        guard let error = error as? Network.URLSessionError,
              case let Network.URLSessionError.server(_, data, _) = error
        else { return nil }
        
        guard let data, let json = try? JSON(data: data) else { return nil }
        
        switch request {
        case is SignUpRequest:
            return parse(json: json)
        case is SignUpValidationRequest:
            return parse(json: json)
        default:
            return nil
        }
    }
    
    private func parse(json: JSON) -> SignUpError {
        let code = json["code"].intValue
        let message = json["message"].stringValue
        var messages: [String] = []
        var fieldsAttributes: [SignUpError.Field] = []
        
        switch code {
        case 400:
            json["data"].forEach { (k, v) in
                fieldsAttributes.append(.init(name: k, message: v.stringValue))
            }
        case 403:
            messages.append(json["data"].stringValue)
        default:
            break
        }
        
        return SignUpError(
            code: code,
            message: message,
            messages: messages,
            fieldsAttributes: fieldsAttributes
        )
    }
}
