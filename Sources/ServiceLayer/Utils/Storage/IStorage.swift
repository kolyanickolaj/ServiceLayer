//
//  Storage.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/1/23.
//

import Foundation

public typealias StorageAuthoinjection = () -> IStorage?

public protocol IStorage {

    func save<T: Persistable & TIdentifiable>(identifier: String, model: T)

    func fetch<T: Persistable & TIdentifiable>(identifier: String) -> [T]

    func fetch<T: Persistable & TIdentifiable>(identifier: String) -> T?
    
    func fetch<T: Persistable & TIdentifiable>(_ type: T.Type, identifier: String) -> T?
}

extension IStorage {
    
    public func save<T: Persistable & TIdentifiable>(model: T) {
        save(identifier: model.identifier, model: model)
    }
}
