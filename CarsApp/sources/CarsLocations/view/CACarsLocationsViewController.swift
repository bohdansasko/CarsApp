//
//  CACarsLocationsViewController.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/5/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import UIKit
import MapKit

protocol CACarsLocationsViewControllerInputProtocol: class {
    func addAnnotations(_ annotations: [CACarAnnotation])
}

class CACarsLocationsViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: CACarsLocationsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configure(with: mapView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.showCars()
    }
}

extension CACarsLocationsViewController: CACarsLocationsViewControllerInputProtocol {
    func addAnnotations(_ annotations: [CACarAnnotation]) {
        mapView.addAnnotations(annotations)
        guard let firstAnnotationRegion = annotations.first?.region else { return }
        mapView.setRegion(firstAnnotationRegion, animated: true)
    }
}
