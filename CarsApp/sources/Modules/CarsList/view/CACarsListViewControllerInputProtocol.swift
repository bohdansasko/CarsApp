//
//  CACarsListViewControllerInputProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

protocol CACarsListViewControllerInputProtocol: class {
    var carsList: UITableView! { get }
    
    func setupList(dataSource: UITableViewDataSource, delegate: UITableViewDelegate)
    func refreshCarsList()
    
    func setActivityIndicator(isHidden: Bool)
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell?
    func performSegue(withIdentifier identifier: String)
    
    func setMapButtonParams(height: CGFloat, fontSize: CGFloat, titleEdgeInsets: UIEdgeInsets)
}
