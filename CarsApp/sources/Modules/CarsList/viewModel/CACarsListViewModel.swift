//
//  CACarsListViewModel.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

final class CACarsListViewModel: NSObject, CACarsListViewModelProtocol {
    weak var viewControllerInput: CACarsListViewControllerInputProtocol?
    
    var dataSource: CACarsDataSource
    var networkProvider: CANetworkProtocol
    var databaseProvider: CADatabaseProtocol
    
    var selectedCarIndexPath: IndexPath?
    
    required init(viewControllerInput: CACarsListViewControllerInputProtocol, dataSource: CACarsDataSource,
                  networkManager: CANetworkProtocol, databaseProvider: CADatabaseProtocol) {
        self.viewControllerInput = viewControllerInput
        self.dataSource = dataSource
        self.networkProvider = networkManager
        self.databaseProvider = databaseProvider
        
        super.init()
    }
    
    func configure() {
        viewControllerInput?.setupList(dataSource: dataSource, delegate: self)
    }
    
    /// if cars exits in cache/database then fetch them from it else
    /// fetch cars from the internet and then cache it to disk and finally
    /// load them from cache
    func fetchCars() {
        viewControllerInput?.setActivityIndicator(isHidden: false)
        
        fetchDataFromCache()
        
        networkProvider.fetchCars { result in
            if case .success(let carsResult) = result {
                guard let carsResult = carsResult else {
                    print("cars result equal nil")
                    return
                }
                self.databaseProvider.saveCars(carsResult)
                self.fetchDataFromCache()
            }
        }
    }
    
    private func fetchDataFromCache() {
        databaseProvider.fetchCars({ result in
            switch result {
            case .success(let carsResult):
                self.dataSource.cars = carsResult
            case .failure(let error):
                self.dataSource.cars = nil
                print(#function, error.localizedDescription)
            }
            self.viewControllerInput?.setActivityIndicator(isHidden: true)
            self.viewControllerInput?.refreshCarsList()
        })
    }
    
    func prepare(for segue: UIStoryboardSegue) {
        guard let carsMapViewController = segue.destination as? CACarsLocationsViewController else {
            return
        }
        
        switch segue.identifier {
        case CAStorybordSegue.toCarsMap.rawValue:
            carsMapViewController.viewModel.cars = dataSource.cars!
        case CAStorybordSegue.toCarMap.rawValue:
            guard
                let selectedCarIndexPath = selectedCarIndexPath,
                let car = dataSource.cars?.car(by: selectedCarIndexPath) else {
                    return
            }
            let carsResult = CACarsResult(cars: [car])
            carsMapViewController.viewModel.cars = carsResult
            self.selectedCarIndexPath = nil
        default:
            break
        }
    }
}
