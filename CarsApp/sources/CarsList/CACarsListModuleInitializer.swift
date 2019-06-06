//
//  CACarsListModuleInitializer.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/7/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

final class CACarsListModuleInitializer: NSObject {
    @IBOutlet weak var viewController: CACarsListViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let assembly = CACarsListModuleAssembly()
        assembly.configure(viewController: viewController)
    }
}
