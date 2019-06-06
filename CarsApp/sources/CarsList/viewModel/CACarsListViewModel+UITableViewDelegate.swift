//
//  CACarsListViewModel+UITableViewDelegate.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/6/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

extension CACarsListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let car = dataSource.cars?.car(by: indexPath) else {
            return
        }
        
        networkProvider.imageDownloadManager.downloadImage(car, indexPath: indexPath) {
            image, url, idxPath, error in
            guard
                let idxPath = idxPath,
                let carCell = self.viewControllerInput?.cellForRow(at: idxPath) as? CACarListCellProtocol,
                let car = self.dataSource.cars?.car(by: idxPath) else {
                    return
            }
            carCell.updateCell(with: car, carImage: image ?? UIImage(named: "mini"))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCarIndexPath = indexPath
        viewControllerInput?.performSegue(withIdentifier: CAStorybordSegue.toCarMap.rawValue)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let car = self.dataSource.cars?.car(by: indexPath) else {
            return
        }
        networkProvider.imageDownloadManager.slowDownImageDownloadTaskFor(car.carImageUrl)
    }
}
