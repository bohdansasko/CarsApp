//
//  CACars.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

struct CACars {
    let items: [CACar]
    
    init(from data: Data) throws {
        items = try JSONDecoder().decode([CACar].self, from: data)
    }
}
