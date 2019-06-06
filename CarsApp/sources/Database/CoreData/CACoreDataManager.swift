//
//  CACoreDataManager.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import CoreData

final class CACoreDataManager: CADatabaseProtocol {
    let persistentStore: NSPersistentContainer = {
        let container = NSPersistentContainer(name: kCADatabaseName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let err = error {
                print("Error setting up core data stack:", err)
            }
        })
        return container
    }()
    
    func fetchCars(_ completion: @escaping (Result<CACarsResult?, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<CACarEntity> = CACarEntity.fetchRequest()
        
        let viewContext = persistentStore.viewContext
        viewContext.perform {
            do {
                let cars = try viewContext.fetch(fetchRequest)
                let carsResult = CACarsResult(cars: cars.compactMap({ CACar(fromEntity: $0) }) )
                completion(.success(carsResult))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func saveCars(_ carsResult: CACarsResult) {
        let viewContext = persistentStore.viewContext
        var carsEntities: [CACarEntity] = []
        
        viewContext.performAndWait {
            for car in carsResult.cars() {
                carsEntities.append( CACarEntity(car: car, context: viewContext) )
            }
        }
        
        do {
            print(#function)
            try persistentStore.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
