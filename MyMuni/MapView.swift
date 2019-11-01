//
//  MapView.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 9/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import SwiftUI
import MapKit
import UIKit

struct MapView: UIViewRepresentable {
    let vehicleLocationRequest = APIRequest(resource: VehicleLocationsResource())
    private let locationManager = CLLocationManager()
    @Binding var favoriteColor: Int
    
    func makeUIView(context: Context) -> MKMapView {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        let view = MKMapView(frame: .zero)
        view.showsUserLocation = true
        return view
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)
        view.delegate = context.coordinator
        
        let dirTag = self.$favoriteColor.wrappedValue == 0 ? "O" : "I"
        var annotationDict : [String: BusAnnotation] = [:]
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { time in
            var annotations  : [BusAnnotation] = []
            self.vehicleLocationRequest.load(withCompletion: { (vehicleLocations: [VehicleLocation]?) in
                vehicleLocations?.filter{$0.dirTag!.contains(dirTag)}.forEach { location in
                    let thisCoord = CLLocationCoordinate2D(latitude: Double(location.lat)!, longitude: Double(location.lon)!)
                    if(annotationDict[location.id] != nil) {
                        let thisAnnotation = annotationDict[location.id]
                        thisAnnotation?.coordinate = thisCoord
                        thisAnnotation?.subtitle = location.secsSinceReport
                    } else {
                        let annotation = BusAnnotation(coordinate: thisCoord)
                        annotation.title = location.dirTag
                        annotation.subtitle = location.secsSinceReport
                        annotations.append(annotation)
                        annotationDict[location.id] = annotation
                    }
                }
                if annotations.count > 0 {
                    view.addAnnotations(annotations)
                    annotations = []
                }
            })
        })
    }
}
