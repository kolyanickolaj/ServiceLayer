//
//  DBDataObject.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/27/23.
//

import Foundation
import CoreData

@objc(DBDataObject)
public class DBDataObject: NSManagedObject {}

extension DBDataObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBDataObject> {
        NSFetchRequest<DBDataObject>(entityName: entityName)
    }
    @NSManaged public var data: Data
    @NSManaged public var identifier: String
    @NSManaged public var timestamp: Double
}

extension DBDataObject: Identifiable { }

