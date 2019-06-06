//
//  CACarsLocationsViewModel.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/5/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import MapKit

final class CACarsLocationsViewModel: CACarsLocationsViewModelProtocol {
    var kCarAnnotationReuseIdentifier: String { return CAConstants.kCAMapCarAnnotation }
    
    weak var viewControllerInput: CACarsLocationsViewControllerInputProtocol?
    var cars: CACarsResult!
    
    required init(with viewControllerInput: CACarsLocationsViewControllerInputProtocol) {
        self.viewControllerInput = viewControllerInput
    }
    
    func configure(with mapView: MKMapView) {
        mapView.register(CACarAnnotation.self, forAnnotationViewWithReuseIdentifier: kCarAnnotationReuseIdentifier)
    }
    
    func showCars() {
        let annotations = cars.cars().compactMap({ car -> CACarAnnotation? in
            let coordinate = CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude)
            return CACarAnnotation(coordinate: coordinate, title: car.make, subtitle: car.name)
        })
        viewControllerInput?.addAnnotations(annotations)
    }
}
