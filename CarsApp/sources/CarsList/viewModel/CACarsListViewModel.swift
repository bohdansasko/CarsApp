//
//  CACarsListViewModel.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

class CACarsListViewModel: NSObject, CACarsListViewModelProtocol {
    weak var viewControllerInput: CACarsListViewControllerInputProtocol?
    
    var dataSource: CACarsDataSource
    var networkProvider: CANetworkProtocol
    
    var selectedCarIndexPath: IndexPath?
    
    required init(viewControllerInput: CACarsListViewControllerInputProtocol, dataSource: CACarsDataSource, networkManager: CANetworkProtocol) {
        self.viewControllerInput = viewControllerInput
        self.dataSource = dataSource
        self.networkProvider = networkManager
        
        super.init()
    }
    
    func configure() {
        viewControllerInput?.setupList(dataSource: dataSource, delegate: self)
    }
    
    func fetchCars() {
        viewControllerInput?.setActivityIndicator(isHidden: false)
        
        networkProvider.fetchCars { result in
            switch result {
            case .success(let carsResult):
                self.dataSource.cars = carsResult
            case .failure(let error):
                self.dataSource.cars = nil
                print(error.localizedDescription)
            }
            self.viewControllerInput?.setActivityIndicator(isHidden: true)
            self.viewControllerInput?.refreshCarsList()
        }
    }
    
    func prepare(for segue: UIStoryboardSegue) {
        guard let carsMapViewController = segue.destination as? CACarsLocationsViewController else {
            return
        }
        
        switch segue.identifier {
        case CAStorybordSegue.toCarsMap.rawValue:
            carsMapViewController.viewModel = CACarsLocationsViewModel(with: carsMapViewController, cars: dataSource.cars!)
        case CAStorybordSegue.toCarMap.rawValue:
            guard
                let selectedCarIndexPath = selectedCarIndexPath,
                let car = dataSource.cars?.car(by: selectedCarIndexPath) else {
                    return
            }
            let carsResult = CACarsResult(cars: [car])
            carsMapViewController.viewModel = CACarsLocationsViewModel(with: carsMapViewController, cars: carsResult)
            self.selectedCarIndexPath = nil
        default:
            break
        }
    }
}
