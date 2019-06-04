//
//  CANetworkManager.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation
import Moya

protocol CANetworkable {
    var apiProvider: MoyaProvider<CACarsAPI> { get }
    
    func fetchCars(_ completion: @escaping (Result<CACarsResult?, Error>) -> Void)
}

class CANetworkManager: CANetworkable {
    var apiProvider = MoyaProvider<CACarsAPI>()
    
    func fetchCars(_ completion: @escaping (Result<CACarsResult?, Error>) -> Void) {
        apiProvider.request(.carsList) { result in
            switch result {
            case .success(let response):
                let cars = try? CACarsResult(from: response.data)
                completion(.success(cars))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
