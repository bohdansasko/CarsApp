//
//  CAImageStoreProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

protocol CAImageStoreProtocol {
    func image(forKey key: String) -> UIImage?
    func save(_ image: UIImage, for key: String)
    func delete(for key: String)
}
