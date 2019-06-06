//
//  CACarsLocationsModuleInitializer.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/7/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Foundation

final class CACarsLocationsModuleInitializer: NSObject {
    @IBOutlet weak var viewController: CACarsLocationsViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let assembly = CACarsLocationsModuleAssembly()
        assembly.configure(viewController: viewController)
    }
}
