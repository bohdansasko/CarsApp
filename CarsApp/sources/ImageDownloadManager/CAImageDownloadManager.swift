//
//  CAImageDownloadManager.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/5/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

final class CAImageDownloadManager {
    var imageStore: CAImageStoreProtocol
    
    private var completionHandler: CAImageDownloadHandler?
    private let imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.ca.imageDownloadQueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()

    init(imageStore: CAImageStoreProtocol) {
        self.imageStore = imageStore
    }
}

extension CAImageDownloadManager: CAImageDownloadManagerProtocol {
    func downloadImage(_ car: CACar, indexPath: IndexPath?, _ completion: @escaping CAImageDownloadHandler) {
        print("download ", car.carImageUrl)
        completionHandler = completion
        
        guard let url = URL(string: car.carImageUrl) else {
            print("can't make url")
            return
        }
        
        // trying to get image from cache or disk
        let imageKey = car.id
        if let image = imageStore.image(forKey: imageKey) {
            print("return cached image for \(url)")
            OperationQueue.main.addOperation {
                self.completionHandler?(image, url, indexPath, nil)
            }
        } else {
            // check if image currenly downloading and if yes then set high priority
            if let operations = imageDownloadQueue.operations as? [CAOperation],
               let firstOperation = operations.filter({
                    $0.imageURL.absoluteString == url.absoluteString && $0.isActive()
                }).first {
                print("set high priority for \(url)")
                firstOperation.queuePriority = .high
            } else {
                // create new task for download image
                let operation = CAOperation(url: url, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .veryHigh
                }
                operation.downloadHandler = { image, url, indexPath, error in
                    if let downloadedImage = image {
                        self.imageStore.save(downloadedImage, for: imageKey)
                    }
                    OperationQueue.main.addOperation {
                        self.completionHandler?(image, url, indexPath, error)
                    }
                }
                print("create new task for \(url)")
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    func slowDownImageDownloadTaskFor(_ absoluteImageURL: String) {
        guard let imageURL = URL(string: absoluteImageURL) else {
            return
        }
        if let operations = imageDownloadQueue.operations as? [CAOperation] {
            let executingOperations = operations.filter({
                $0.imageURL.absoluteString == imageURL.absoluteString && $0.isActive()
            })
            guard let operation = executingOperations.first else { return }
            operation.queuePriority = .low
            print("set low priority for", absoluteImageURL)
        }
    }
}
