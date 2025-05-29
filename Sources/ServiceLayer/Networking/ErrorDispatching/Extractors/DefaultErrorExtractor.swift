//
//  DefaultErrorExtractor.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation
import SwiftyJSON

public final class DefaultErrorExtractor: ErrorExtracting {
  
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    public func extract(request: RequestResource, error: Error?) -> Error? {
        guard let error = error as? Network.URLSessionError,
              case let Network.URLSessionError.server(code, data, _) = error
        else { return nil }
        
        switch request {
        case is SignUpValidationRequest:
            return nil
        default: break
        }
        
        guard let data else {
            return clientError(for: code.statusCode, remoteData: nil)
        }
        do {
            let json = try JSON(data: data)
            let code = json["code"].intValue
            return clientError(for: code, remoteData: data)
        } catch {
            return clientError(for: code.statusCode, remoteData: nil)
        }
    }
    
    // MARK: - Private
    
    private func clientError(for code: Int, remoteData: Data?) -> Error? {
        switch code {
        case 401:
            guard let remoteData, let jsonData = try? JSON(data: remoteData) else { return  nil }
            
            if let error = try? decoder.decode(UnauthorizedError.self, from: remoteData) {
                return error
            } else if let message = jsonData["message"].string {
                return UnauthorizedError(messages: [message])
            } else {
                return nil
            }
        case 403:
            guard let remoteData else { return nil }
            return try? decoder.decode(GameSessionError.self, from: remoteData)
        case 400:
            guard let remoteData else { return nil }
            return try? decoder.decode(ClientError.self, from: remoteData)
        case 429:
            return DefaultErrors.custom(text: Localization.tooManyRequests.localized)
        default:
            return nil
        }
    }
}
