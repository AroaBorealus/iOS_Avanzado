//
//  CoreDBTransformation+CoreDataClass.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 24/10/24.
//
//

import Foundation
import CoreData

@objc(CoreDBTransformation)
public class CoreDBTransformation: NSManagedObject {

}

extension CoreDBTransformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDBTransformation> {
        return NSFetchRequest<CoreDBTransformation>(entityName: "CoreDBTransformation")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var detail: String?
    @NSManaged public var character: CoreDBCharacter?

}

extension CoreDBTransformation : Identifiable {

}
