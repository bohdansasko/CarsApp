//
//  CACarsListViewModelProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

protocol CACarsListViewModelProtocol {
    var dataSource: CACarsDataSource { get }
    var networkProvider: CANetworkProtocol { get }
    var viewController: CACarsListViewControllerInputProtocol? { get }
    
    init(viewController: CACarsListViewControllerInputProtocol, dataSource: CACarsDataSource, networkManager: CANetworkProtocol)
    
    func configure()
    func fetchCars()
}
