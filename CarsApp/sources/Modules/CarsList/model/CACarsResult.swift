//
//  CACarsResult.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

struct CACarsResult {
    private let items: [CACar]
    
    init() { items = [] }
    
    init(cars: [CACar]) { items = cars }
    
    init(from data: Data) throws {
        items = try JSONDecoder().decode([CACar].self, from: data)
    }
    
    func count() -> Int {
        return items.count
    }
    
    func car(by indexPath: IndexPath) -> CACar {
        return items[indexPath.row]
    }
    
    func cars() -> [CACar] {
        return items
    }
}
