//
//  CACarEntity+CoreDataProperties.swift
//  
//
//  Created by Bogdan Sasko on 6/6/19.
//
//

import Foundation
import CoreData


extension CACarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CACarEntity> {
        return NSFetchRequest<CACarEntity>(entityName: "CACarEntity")
    }

    @NSManaged public var carImageUrl: String?
    @NSManaged public var color: String?
    @NSManaged public var fuelLevel: Double
    @NSManaged public var fuelType: String?
    @NSManaged public var group: String?
    @NSManaged public var id: String?
    @NSManaged public var innerCleanliness: String?
    @NSManaged public var latitude: Double
    @NSManaged public var licensePlate: String?
    @NSManaged public var longitude: Double
    @NSManaged public var make: String?
    @NSManaged public var modelIdentifier: String?
    @NSManaged public var modelName: String?
    @NSManaged public var name: String?
    @NSManaged public var series: String?
    @NSManaged public var transmission: String?

}
