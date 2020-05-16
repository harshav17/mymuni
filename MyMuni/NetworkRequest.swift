//
//  NetworkRequest.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 9/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(self.decode(data!))
        }.resume()
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        do {
            let res = try JSONDecoder().decode(Wrapper<Resource.ModelType>.self, from: data)
            return res.vehicle
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func load(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

protocol APIResource {
    associatedtype ModelType: Codable
    var methodPath: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "http://webservices.nextbus.com")!
        components.path = methodPath
        components.queryItems = queryItems
        return components.url!
    }
}

struct VehicleLocationsResource: APIResource {
    typealias ModelType = VehicleLocation
    let methodPath = "/service/publicJSONFeed"
    let queryItems = [
        URLQueryItem(name: "command", value: "vehicleLocations"),
        URLQueryItem(name: "a", value: "sf-muni"),
        URLQueryItem(name: "r", value: "1")
    ]
}


