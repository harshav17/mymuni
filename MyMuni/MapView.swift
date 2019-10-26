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
    private var request: AnyObject?
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.765489, longitude: -122.475369)
        view.setCenter(coordinate, animated: true)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        view.setRegion(region, animated: true)
    }
    
    mutating func fetchVehicleLocations() {
        let vehicleLocationRequest = APIRequest(resource: VehicleLocationsResource())
        request = vehicleLocationRequest
        vehicleLocationRequest.load(withCompletion: <#T##([VehicleLocation]?) -> Void#>)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
