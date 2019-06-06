//
//  CAImageStore.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

final class CAImageStore {
    static let shared = CAImageStore()
    
    private init() {}
    private var cache = NSCache<AnyObject, UIImage>()
}

extension CAImageStore: CAImageStoreProtocol {
    /* methods works in the 3 steps
     1. try to get image from cache if it exists and return it
     2. try to get image from disk if it exists
     3. if image exists add image to cache and return it
     */
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            print(#function, "return image for key \(key) from cache")
            return existingImage
        }
        
        guard
            let imageURLOnADisk = imageURL(for: key),
            let imageFromDisk = UIImage(contentsOfFile: imageURLOnADisk.path) else {
                print(#function, "couldn't find image for key \(key) at the disk")
                return nil
        }
        
        print(#function, "return image for key \(key) from disk")
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    /// save image to cache and disk with using jpeg format and 0.5 quality
    func save(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        guard let imageURLOnADisk = imageURL(for: key) else {
            print(#function, "couldn't get image url for key = \(key)")
            return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            do {
                try imageData.write(to: imageURLOnADisk, options: [.atomic])
            } catch {
                print(#function, error.localizedDescription)
            }
        }
    }
    
    /// delete image from cache and disk
    func delete(for key: String) {
        cache.removeObject(forKey: key as NSString)
        
        guard let imageURLOnADisk = imageURL(for: key) else {
            print(#function, "couldn't get image url for key = \(key)")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: imageURLOnADisk)
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}

private extension CAImageStore {
    func imageURL(for key: String) -> URL? {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDir = documentsDir.first else {
            return nil
        }
        return documentDir.appendingPathComponent(key)
    }
}
