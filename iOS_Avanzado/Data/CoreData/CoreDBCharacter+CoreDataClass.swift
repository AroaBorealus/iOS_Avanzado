//
//  CoreDBCharacter+CoreDataClass.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 24/10/24.
//
//

import Foundation
import CoreData

@objc(CoreDBCharacter)
public class CoreDBCharacter: NSManagedObject {

}

extension CoreDBCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDBCharacter> {
        return NSFetchRequest<CoreDBCharacter>(entityName: "CoreDBCharacter")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var detail: String?
    @NSManaged public var locations: Set<CoreDBLocation>?
    @NSManaged public var transformations: Set<CoreDBTransformation>?

}

// MARK: Generated accessors for locations
extension CoreDBCharacter {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: CoreDBLocation)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: CoreDBLocation)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: Set<CoreDBLocation>)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: Set<CoreDBLocation>)

}

// MARK: Generated accessors for transformations
extension CoreDBCharacter {

    @objc(addTransformationsObject:)
    @NSManaged public func addToTransformations(_ value: CoreDBTransformation)

    @objc(removeTransformationsObject:)
    @NSManaged public func removeFromTransformations(_ value: CoreDBTransformation)

    @objc(addTransformations:)
    @NSManaged public func addToTransformations(_ values: Set<CoreDBTransformation>)

    @objc(removeTransformations:)
    @NSManaged public func removeFromTransformations(_ values: Set<CoreDBTransformation>)

}

extension CoreDBCharacter : Identifiable {

}
