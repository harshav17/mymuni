//
//  MapViewCoordinator.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 10/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import Foundation
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewCoordinator: MapView
    
    init(_ control: MapView) {
        self.mapViewCoordinator = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
        annotationView.canShowCallout = true
        
        if annotation !== mapView.userLocation {
            annotationView.image = UIImage(systemName: "tram.fill")
        } else {
            annotationView.image = UIImage(systemName: "person.fill")
        }
        return annotationView
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let coordinate = mapView.userLocation.coordinate
        mapView.setCenter(coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
}
