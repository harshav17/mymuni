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
    @Binding var locations: [BusAnnotation]
    var localColor: Int = -1
    
    func makeUIView(context: Context) -> MKMapView {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        let view = MKMapView(frame: .zero)
        view.showsUserLocation = true
        
        //view.userLocation.coordinate
        let coordinate = CLLocationCoordinate2D(latitude: 37.7749300, longitude: -122.4194200)
        view.setCenter(coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        view.setRegion(region, animated: true)
        
        return view
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        
        //add buses
        view.removeAnnotations(view.annotations)
        view.addAnnotations(locations)
        
        //add route
        view.removeOverlays(view.overlays)
        getRoute(view: view)
    }
    
    func getRoute(view: MKMapView) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: "http://webservices.nextbus.com/service/publicJSONFeed?command=routeConfig&a=sf-muni&r=7X")!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                print("no values found for stops")
                return
            }
            let wrapper = try? JSONDecoder().decode(RouteWrapper.self, from: data)
            let stops = wrapper?.route.stop
            let directions = wrapper?.route.direction
            let dirTag = self.$favoriteColor.wrappedValue == 0 ? "O" : "I"
            var routeCoordinates: [CLLocationCoordinate2D] = []
            if directions != nil && stops != nil {
                for direction in directions! {
                    if(direction.tag.contains(dirTag)) {
                        for dirStop in direction.stop {
                            for stop in stops! {
                                if(stop.tag == dirStop.tag) {
                                    let stopCoord = CLLocationCoordinate2D(latitude: Double(stop.lat)!, longitude: Double(stop.lon)!)
                                    routeCoordinates.append(stopCoord)
                                    
                                    let stopAnnotation = MKPointAnnotation()
                                    stopAnnotation.title = stop.title
                                    stopAnnotation.coordinate = stopCoord
                                    view.addAnnotation(stopAnnotation)
                                }
                            }
                        }
                    }
                }
                //let stopCoordinates = stops?.map { CLLocationCoordinate2D(latitude: Double($0.lat)!, longitude: Double($0.lon)!) }
                let polyline = MKPolyline(coordinates: routeCoordinates, count: routeCoordinates.count)
                view.addOverlay(polyline)
            }
        })
        task.resume()
    }
}
