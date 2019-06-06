//
//  CACarsListModuleAssembly.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/7/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

final class CACarsListModuleAssembly {
    func configure(viewController: CACarsListViewController) {
        let imageDownloadManager = CAImageDownloadManager(imageStore: CAImageStore.shared)
        let networkManager = CANetworkManager(imageDownloadManager: imageDownloadManager)
        
        viewController.viewModel = CACarsListViewModel(
            viewControllerInput: viewController,
            dataSource: CACarsDataSource(),
            networkManager: networkManager)
    }
}
