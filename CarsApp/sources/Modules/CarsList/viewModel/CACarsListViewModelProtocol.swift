//
//  CACarsListViewModelProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

protocol CACarsListViewModelProtocol {
    var dataSource: CACarsDataSource { get }
    var networkProvider: CANetworkProtocol { get }
    var databaseProvider: CADatabaseProtocol { get }
    var viewControllerInput: CACarsListViewControllerInputProtocol? { get }
    
    init(viewControllerInput: CACarsListViewControllerInputProtocol,
         dataSource: CACarsDataSource,
         networkManager: CANetworkProtocol,
         databaseProvider: CADatabaseProtocol)
    
    func configure()
    func fetchCars()
    
    func prepare(for segue: UIStoryboardSegue)
}
