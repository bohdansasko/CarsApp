//
//  CACarsListViewController.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

class CACarsListViewController: UIViewController {
    @IBOutlet weak var carsList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: CACarsListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CACarsListViewModel(viewController: self,
                            dataSource: CACarsDataSource(),
                            networkManager: CANetworkManager(imageDownloadManager: CAImageDownloadManager.shared))
        viewModel.configure()
        viewModel.fetchCars()
    }
}

extension CACarsListViewController: CACarsListViewControllerInputProtocol {
    func setupList(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        carsList.dataSource = dataSource
        carsList.delegate = delegate
    }
    
    func refreshCarsList() {
        OperationQueue.main.addOperation {
            self.carsList.reloadData()
        }
    }
    
    func setActivityIndicator(isHidden: Bool) {
        activityIndicator.isHidden = isHidden
    }
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        return carsList.cellForRow(at: indexPath)
    }
}



