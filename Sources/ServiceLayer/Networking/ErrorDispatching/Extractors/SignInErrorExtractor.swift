//
//  SignInErrorExtractor.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/27/23.
//

import Foundation
import SwiftyJSON

public final class SignInErrorExtractor: ErrorExtracting {
    
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
        guard request is SignInRequest else { return nil }
        guard let data, let json = try? JSON(data: data) else { return nil }
        return parse(json: json)
    }
    
    func parse(json: JSON) -> LoginError? {
        let code = json["code"].intValue
        guard code == 400 || code == 403 else { return nil }
        let apiErrorCode = json["data"]["apiErrorCode"].intValue
        let errorCode = LoginError.ErrorCode(rawValue: apiErrorCode) ?? .unowned
        let messages = json["data"]["messages"].arrayValue.map { $0.stringValue }
        
        var attributes: [String: String] = [:]
        json["data"].forEach { (k, v) in
            guard k != "messages" else { return }
            attributes[k] = v.stringValue
        }
        return LoginError(
            apiCode: errorCode,
            networkCode: code,
            messages: messages,
            attributes: attributes
        )
    }
}
