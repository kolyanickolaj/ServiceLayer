//
//  ModelRequest.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/1/23.
//

import Foundation

public protocol ModelRequest: RequestResource {

    associatedtype Model: JSONParsable

    var payloadKey: String? { get }
}
