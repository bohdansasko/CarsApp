//
//  CACarsLocationsViewModel.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/5/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import MapKit

final class CACarsLocationsViewModel: CACarsLocationsViewModelProtocol {
    var kCarAnnotationReuseIdentifier: String { return "CarAnnotation" }
    
    weak var viewControllerInput: CACarsLocationsViewControllerInputProtocol?
    var cars: CACarsResult
    
    required init(with viewControllerInput: CACarsLocationsViewControllerInputProtocol, cars: CACarsResult) {
        self.viewControllerInput = viewControllerInput
        self.cars = cars
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
