//
//  CACarListCell.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit

// MARK: CACarListCellProtocol

protocol CACarListCellProtocol {
    func updateCell(with car: CACar?, carImage: UIImage?)
}

// MARK: CACarListCell

class CACarListCell: UITableViewCell {
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var makeNameLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!

    @IBOutlet weak var seriesValueLabel: UILabel!
    @IBOutlet weak var fuelTypeValueLabel: UILabel!
    @IBOutlet weak var fuelLevelValueLabel: UILabel!
    
    @IBOutlet weak var transmissionTypeLabel: UILabel!
    @IBOutlet weak var licenseNumberLabel: UILabel!
    @IBOutlet weak var cleanlinessTypeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateCell(with: nil, carImage: nil)
    }
}

extension CACarListCell: CACarListCellProtocol {
    func updateCell(with car: CACar?, carImage: UIImage?) {
        carImageView.image = carImage
        
        ownerNameLabel.text = car?.name
        makeNameLabel.text = car?.make
        groupNameLabel.text = car?.group
        
        seriesValueLabel.text = car?.series
        fuelTypeValueLabel.text = car?.fuelType
        fuelLevelValueLabel.text = String(car?.fuelLevel ?? 0)
        
        transmissionTypeLabel.text = car?.transmission
        licenseNumberLabel.text = car?.licensePlate
        cleanlinessTypeLabel.text = car?.innerCleanliness
    }
}
