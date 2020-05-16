//
//  BusAnnotation.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 10/28/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import Foundation
import MapKit

class BusAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    dynamic var title: String?
    dynamic var subtitle: String?
    
    init(location: VehicleLocation) {
        self.coordinate = .init(latitude: Double(location.lat)!, longitude: Double(location.lon)!)
        self.title = "\(location.secsSinceReport) secs ago"
        self.subtitle = location.dirTag
        
        super.init()
    }
}
