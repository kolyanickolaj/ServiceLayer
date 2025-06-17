//
//  CoreDataStorage.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/26/23.
//

import Foundation
import CoreData

public final class CoreDataStorage<ResultType> where ResultType : NSManagedObject {
    
    public init() {}
    
    private(set) lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    private lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource: "DB", withExtension: "momd") else {
            fatalError("❌ Couldn't find DB.momd in Bundle.module")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("❌ Couldn't load model from URL \(modelURL)")
        }

        let container = NSPersistentContainer(name: "DB", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (_, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

// MARK: - IStorage

extension CoreDataStorage: IStorage {
    public func fetch<T>(_ type: T.Type, identifier: String) -> T? where T: TIdentifiable, T: Persistable {
        fetch(identifier: identifier)
    }
    
    public func save<T: Persistable & TIdentifiable>(identifier: String, model: T) {
        do {
            let managedContext = persistentContainer.viewContext
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            _ = model.createDB(in: managedContext)
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    public func fetch<T: Persistable & TIdentifiable>(identifier: String) -> [T] where T.DBType == NSManagedObject {
        do {
            let entityName = String(describing: ResultType.self)
            let request = NSFetchRequest<ResultType>(entityName: entityName)
            request.predicate = NSPredicate(format: "identifier = %@", identifier)
            request.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: false)]
            
            let fetchedObjects = try context.fetch(request)
            return fetchedObjects.compactMap { try? T.from($0) }
        } catch {
            print(error)
            return []
        }
    }
    
    public func fetch<T: Persistable & TIdentifiable>(identifier: String) -> [T] {
        do {
            let entityName = String(describing: ResultType.self)
            let request = NSFetchRequest<ResultType>(entityName: entityName)
            request.predicate = NSPredicate(format: "identifier = %@", identifier)
            request.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: false)]
            let fetchedObjects = try context.fetch(request)
            return fetchedObjects
                .compactMap { $0 as? T.DBType }
                .compactMap { try? T.from($0) }
        } catch {
            print(error)
            return []
        }
    }

    public func fetch<T: Persistable & TIdentifiable>(identifier: String) -> T? {
        fetch(identifier: identifier).first
    }
}
