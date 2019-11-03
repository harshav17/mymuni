//
//  Model types.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 9/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import Foundation

struct Wrapper<T: Codable>: Codable {
    let vehicle: [T]?
}

struct RouteWrapper: Codable {
    let route: Route
}

struct Route: Codable {
    let stop: [Stop]
    let direction: [Direction]
}

struct Direction: Codable {
    let title: String
    let tag: String
    let name: String
    let stop: [DirStop]
}

struct DirStop: Codable {
    let tag: String
}

struct Stop: Codable {
    let lon: String
    let lat: String
    let title: String
    let stopId: String
    let tag: String
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
