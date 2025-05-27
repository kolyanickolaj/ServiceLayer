//
//  DataObject.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/27/23.
//

import Foundation
import CoreData
import ServiceLayer

struct DataObject: TIdentifiable {
    let identifier: String
    let data: Data
    let timestamp: Double
    
    init(identifier: String, data: Data, timestamp: Double = Date().timeIntervalSince1970) {
        self.identifier = identifier
        self.data = data
        self.timestamp = timestamp
    }
}

extension DataObject: Persistable {
    
    static func from(_ model: DBDataObject) throws -> Self {
        return .init(
            identifier: model.identifier,
            data: model.data,
            timestamp: model.timestamp
        )
    }

    func createDB(in context: NSManagedObjectContext) -> DBDataObject {
        let object = createPersistanceObject(context)
        object.data = data
        object.identifier = identifier
        object.timestamp = timestamp
        return object
    }
}
