//
//  CADatabaseProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

protocol CADatabaseProtocol {
    func fetchCars(_ completion: @escaping (Result<CACarsResult?, Error>) -> Void)
    func saveCars(_ carsResult: CACarsResult)
}
