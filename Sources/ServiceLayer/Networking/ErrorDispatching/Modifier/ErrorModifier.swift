//
//  URLErrorModifier.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation

public final class ErrorModifier: ErrorModifying {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    public func modify(error: Error) -> Error? {
        switch error {
        case let fetch as FetchAndDecodeError:
            switch fetch {
            case .decode(let error):
                return error
            case .fetch(let error):
                return modify(error: error)
            }
        case let sessionError as Network.URLSessionError:
            return sessionError
        default:
            return nil
        }
    }
}
