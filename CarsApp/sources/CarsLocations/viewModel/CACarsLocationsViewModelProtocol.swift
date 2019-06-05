//
//  CACarsLocationsViewModelProtocol.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/5/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import MapKit

protocol CACarsLocationsViewModelProtocol {
    var kCarAnnotationReuseIdentifier: String { get }
    
    var viewControllerInput: CACarsLocationsViewControllerInputProtocol? { get }
    var cars: CACarsResult { get set }
    
    init(with viewController: CACarsLocationsViewControllerInputProtocol, cars: CACarsResult)
    func configure(with mapView: MKMapView)
    
    func showCars()
}
