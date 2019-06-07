//
//  CACoreDataManager.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import CoreData

final class CACoreDataManager: CADatabaseProtocol {
    static let shared = CACoreDataManager()
    
    let persistentStore: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CAConstants.kCADatabaseName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let err = error {
                print("Error setting up core data stack:", err)
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext { return persistentStore.viewContext }
    
    func fetchCars(_ completion: @escaping (Result<CACarsResult?, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<CACarEntity> = CACarEntity.fetchRequest()
        
        viewContext.perform {
            do {
                let cars = try self.viewContext.fetch(fetchRequest)
                let carsResult = CACarsResult(cars: cars.compactMap({ CACar(fromEntity: $0) }) )
                completion(.success(carsResult))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func saveCars(_ carsResult: CACarsResult) {
        print(#function)
        var carsEntities: [CACarEntity] = []
        
        viewContext.performAndWait {
            for car in carsResult.cars() {
                if self.isCarInDB(car) {
                    print("car \(car.id) exists in database")
                } else {
                    print("car \(car.id) append to database")
                    carsEntities.append( CACarEntity(car: car, context: self.viewContext) )
                }
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isCarInDB(_ car: CACar) -> Bool {
        let request: NSFetchRequest<CACarEntity> = CACarEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ ", "id", car.id)
        
        var result: [CACarEntity] = []
        viewContext.performAndWait {
            do {
                result = try self.viewContext.fetch(request)
            } catch {
                print(#function, error.localizedDescription)
            }
        }
        
        return !result.isEmpty
    }
}
