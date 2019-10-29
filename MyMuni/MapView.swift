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
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.765489, longitude: -122.475369)
        view.setCenter(coordinate, animated: true)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        view.setRegion(region, animated: true)
        
        var annotationDict : [String: BusAnnotation] = [:]
        
        Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { time in
            var annotations  : [BusAnnotation] = []
            self .vehicleLocationRequest.load(withCompletion: { (vehicleLocations: [VehicleLocation]?) in
                vehicleLocations?.forEach { location in
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
