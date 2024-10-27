//
//  CoreDBLocation+CoreDataClass.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 24/10/24.
//
//

import Foundation
import CoreData

@objc(CoreDBLocation)
public class CoreDBLocation: NSManagedObject {

}

extension CoreDBLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDBLocation> {
        return NSFetchRequest<CoreDBLocation>(entityName: "CoreDBLocation")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var character: CoreDBCharacter?

}

extension CoreDBLocation : Identifiable {

}
