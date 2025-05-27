//
//  CompoundErrorExtractor.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 12/26/23.
//

import Foundation

open class CompoundErrorExtractor: ErrorExtracting {
    
    public let extractors: [ErrorExtracting]
    
    public init(extractors: [ErrorExtracting]) {
        self.extractors = extractors
    }
    
    public func extract(request: RequestResource, error: Error?) -> Error? {
        for extractor in extractors {
            if let error = extractor.extract(
                request: request,
                error: error
            ) {
                return error
            }
        }
        return nil
    }
}
