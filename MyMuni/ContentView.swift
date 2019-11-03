//
//  ContentView.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 9/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var favoriteColor = 0
    @State private var locations: [BusAnnotation] = []
    let vehicleLocationRequest = APIRequest(resource: VehicleLocationsResource())
    
    var body: some View {
        getBuses()
        getBusesOnTimer()
        return ZStack {
            MapView(favoriteColor: $favoriteColor, locations: $locations).edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                Picker(selection: $favoriteColor, label: Text("To where dear sir?"), content: {
                    Image(uiImage: UIImage(named: "home")!).tag(0)
                    Image(uiImage: UIImage(named: "office")!).tag(1)
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 120, height: 60, alignment: .topTrailing)
            }
        }
    }
    
    func getBusesOnTimer() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { time in
            self.getBuses()
        })
    }
    
    func getBuses() {
        self.vehicleLocationRequest.load(withCompletion: { (vehicleLocations: [VehicleLocation]?) in
            if vehicleLocations != nil {
                let dirTag = self.$favoriteColor.wrappedValue == 0 ? "O" : "I"
                self.locations = vehicleLocations?.filter{($0.dirTag != nil && $0.dirTag!.contains(dirTag))}.map{BusAnnotation(location: $0)} ?? []
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
