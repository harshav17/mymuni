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
        if(annotation === mapView.userLocation) {
            return nil
        } else if annotation is MKPointAnnotation {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "stop")
            return annotationView
        } else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "bus")
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}
