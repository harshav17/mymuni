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
    @ObservedObject var preferedRoutes = PreferedRoutes()
    @State private var showRoutesSheet = false
    @State private var refreshCount = 0
    
    var body: some View {
        getBusesOnTimer()
        return ZStack {
            MapView(favoriteColor: $favoriteColor, refreshCount: $refreshCount).edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                HStack {
                    //TODO change this to be a picker for bus number
                    BusPicker(showRoutesSheet: $showRoutesSheet, favoriteColor: $favoriteColor, preferedRoutes: self.preferedRoutes)
                    
                    Button(action: {
                        self.showRoutesSheet.toggle()
                    }) {
                        Image(systemName: "gear")
                    }
                    .frame(width: 20, height: 10, alignment: .top).foregroundColor(.black)
                }
            }
        }
    }

    func getBusesOnTimer() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { time in
            self.refreshCount += 1
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
