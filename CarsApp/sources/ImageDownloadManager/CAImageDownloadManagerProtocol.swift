//
//  CAImageDownloadManagerProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

typealias CAImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void

protocol CAImageDownloadManagerProtocol {
    var imageStore: CAImageStoreProtocol { get }
    
    func downloadImage(_ car: CACar, indexPath: IndexPath?, _ completion: @escaping CAImageDownloadHandler)
    func slowDownImageDownloadTaskFor(_ absoluteImageURL: String)
}
