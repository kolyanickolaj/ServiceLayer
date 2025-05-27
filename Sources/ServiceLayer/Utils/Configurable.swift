//
//  Configurable.swift
//  Tonywin
//
//  Created by Andrey on 6/30/23.
//

import Foundation

public protocol Configurable: AnyObject {

    associatedtype Model

    func configure(_ model: Model)
}
