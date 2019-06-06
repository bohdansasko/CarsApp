//
//  CACarsLocationsModuleAssembly.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/7/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

final class CACarsLocationsModuleAssembly {
    func configure(viewController: CACarsLocationsViewController) {
        viewController.viewModel = CACarsLocationsViewModel(with: viewController)
    }
}
