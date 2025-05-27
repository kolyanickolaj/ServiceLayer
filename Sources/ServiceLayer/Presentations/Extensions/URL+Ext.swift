//
//  URL+Ext.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 28.11.2023.
//

import Foundation

extension URL {
    public init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
