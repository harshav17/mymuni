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
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
}
