//
//  Utils.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/7/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

final class Utils {
    /// true if it's iPhone 5
    static func iPhone5() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: return true
            default: return false
            }
        }
        return false
    }
}
