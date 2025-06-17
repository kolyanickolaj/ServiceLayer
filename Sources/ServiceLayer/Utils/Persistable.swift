//
//  Persistable.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 8/1/23.
//

import Foundation
import CoreData

public protocol TIdentifiable {
    var identifier: String { get }
}

public protocol Persistable {
    associatedtype DBType: NSManagedObject
    
    static var entityName: String { get }
    static var saveBatchSize: Int { get }
    static var removeBatchSize: Int { get }
    static var hasRelationships: Bool { get }
    static func from(_ model: DBType) throws -> Self
    func createDB(in context: NSManagedObjectContext) -> DBType
}

extension Persistable {
    public static var entityName: String { "DBDataObject" }
    
    public static var saveBatchSize: Int { 100 }

    public static var removeBatchSize: Int { 100 }

    public static var hasRelationships: Bool { true }
    
    public func createPersistanceObject(_ context: NSManagedObjectContext) -> DBType {
        print("__--Creating entity: \(DBType.entityName)")
        print("__--Entities in model: \(context.persistentStoreCoordinator?.managedObjectModel.entities.map { $0.name ?? "nil" } ?? [])")
        guard let entity = NSEntityDescription.insertNewObject(
            forEntityName: Self.entityName, into: context) as? DBType
        else {
            fatalError("Can't find model \(DBType.self)")
        }
        return entity
    }
}

extension NSManagedObject {
    public static var entityName: String {
//        if let self = self as? CoreDataModel {
//            print("__--entityName = \(self.entityName)")
//            return self.entityName
//        }
        print("__-- entityName = \(String(describing: self))")
        return String(describing: self)
    }
}
