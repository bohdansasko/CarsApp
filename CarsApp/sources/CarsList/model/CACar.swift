//
//  CACar.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

struct CACar {
    let id: String
    let modelIdentifier: String
    let modelName: String
    let name: String
    let make: String
    let group: String
    let color: String
    let series: String
    let fuelType: String
    let fuelLevel: String
    let transmission: String
    let licensePlate: String
    let latitude: Double
    let longitude: Double
    let innerCleanliness: String
    let carImageUrl: String
}

extension CACar: Decodable {
    private enum CarCodingKeys: String, CodingKey {
        case id
        case modelIdentifier
        case modelName
        case name
        case make
        
        case group
        case color
        case series
        case fuelType
        case fuelLevel
        
        case transmission
        case licensePlate
        case latitude
        case longitude
        case innerCleanliness
        
        case carImageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CarCodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        modelIdentifier = try container.decode(String.self, forKey: .modelIdentifier)
        modelName = try container.decode(String.self, forKey: .modelName)
        name = try container.decode(String.self, forKey: .name)
        make = try container.decode(String.self, forKey: .make)
        
        group = try container.decode(String.self, forKey: .group)
        color = try container.decode(String.self, forKey: .color)
        series = try container.decode(String.self, forKey: .series)
        fuelType = try container.decode(String.self, forKey: .fuelType)
        fuelLevel = try container.decode(String.self, forKey: .fuelLevel)
        
        transmission = try container.decode(String.self, forKey: .transmission)
        licensePlate = try container.decode(String.self, forKey: .licensePlate)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        innerCleanliness = try container.decode(String.self, forKey: .innerCleanliness)
        
        carImageUrl = try container.decode(String.self, forKey: .carImageUrl)
    }
}