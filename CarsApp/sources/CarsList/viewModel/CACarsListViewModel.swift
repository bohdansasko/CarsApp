//
//  CACarsListViewModel.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

class CACarsListViewModel: NSObject, CACarsListViewModelProtocol {
    weak var viewController: CACarsListViewControllerInputProtocol?
    
    var dataSource: CACarsDataSource
    var networkProvider: CANetworkProtocol
    
    required init(viewController: CACarsListViewControllerInputProtocol, dataSource: CACarsDataSource, networkManager: CANetworkProtocol) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.networkProvider = networkManager
        
        super.init()
    }
    
    func configure() {
        viewController?.setupList(dataSource: dataSource, delegate: self)
    }
    
    func fetchCars() {
        viewController?.setActivityIndicator(isHidden: false)
        networkProvider.fetchCars { result in
            switch result {
            case .success(let carsResult):
                self.dataSource.cars = carsResult
            case .failure(let error):
                self.dataSource.cars = nil
                print(error.localizedDescription)
            }
            self.viewController?.setActivityIndicator(isHidden: true)
            self.viewController?.refreshCarsList()
        }
    }
}

extension CACarsListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let carCell = cell as? CACarListCellProtocol,
            let car = dataSource.cars?.car(by: indexPath) else {
                return
        }
        carCell.updateCell(with: car, carImage: UIImage(named: "mini"))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
