//
//  CACarEntity+CoreDataClass.swift
//  
//
//  Created by Bogdan Sasko on 6/6/19.
//
//

import Foundation
import CoreData

@objc(CACarEntity)
public class CACarEntity: NSManagedObject {
    convenience init(car: CACar, context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: CACarEntity.self), in: context)!
        self.init(entity: entityDescription, insertInto: context)
        
        id = car.id
        
        modelIdentifier = car.modelIdentifier
        modelName = car.modelName
        name = car.modelName
        make = car.make
        
        group = car.group
        color = car.color
        series = car.series
        fuelType = car.fuelType
        fuelLevel = car.fuelLevel
        
        transmission = car.transmission
        licensePlate = car.licensePlate
        latitude = car.latitude
        longitude = car.longitude
        innerCleanliness = car.innerCleanliness
        
        carImageUrl = car.carImageUrl
    }
}
