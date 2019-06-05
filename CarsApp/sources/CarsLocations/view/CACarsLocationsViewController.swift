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

        // NOTICE: simple example how to translate string programmaticaly
        title = NSLocalizedString(CALocalizationKey.carsLocations.rawValue,
                                  comment: CALocalizationKey.carsLocations.rawValue) // TODO: should remove after review by company
                                                                                    //       cause translation were implemented via a storyboards
                                                                                    //       and it's break main idea of mvvw :)

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
