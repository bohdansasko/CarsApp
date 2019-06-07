//
//  CACarsListViewController.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

final class CACarsListViewController: UIViewController {
    @IBOutlet weak var carsList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapButton: UIButton!
    
    var viewModel: CACarsListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configure()
        viewModel.fetchCars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        viewModel.prepare(for: segue)
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
    
    func performSegue(withIdentifier identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
    
    func setMapButtonParams(height: CGFloat, fontSize: CGFloat, titleEdgeInsets: UIEdgeInsets) {
        mapButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        mapButton.titleEdgeInsets = titleEdgeInsets
        mapButton.titleLabel?.font = UIFont.verdana(withFontSize: fontSize)
    }
}
