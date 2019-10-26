//
//  Model types.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 9/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import Foundation

struct Wrapper<T: Decodable>: Decodable {
    let items: [T]
}

struct VehicleLocation: Codable {
    let id: String
    let lon: String
    let lat: String
    let routeTag: String?
    let predictable: String
    let speedKmHr: String
    let dirTag: String?
    let heading: String
    let secsSinceReport: String
}
