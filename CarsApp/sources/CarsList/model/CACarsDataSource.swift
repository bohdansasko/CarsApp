//
//  CACarsDataSource.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

class CACarsDataSource: NSObject {
    var cars: CACarsResult?
    let kCarListCellReuseIdentifier = String(describing: CACarListCell.self)
}

extension CACarsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cars = cars else { return 0 }
        return cars.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCarListCellReuseIdentifier, for: indexPath)
        return cell
    }
}
