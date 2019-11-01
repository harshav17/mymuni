//
//  ContentView.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 9/30/19.
//  Copyright © 2019 Harsha Lingampally. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteColor = 0
    var body: some View {
        ZStack {
            MapView(favoriteColor: $favoriteColor).edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                Picker(selection: $favoriteColor, label: Text("To where dear sir?"), content: {
                    Image(systemName: "house.fill").tag(0)
                    Image(systemName: "bed.double.fill").tag(1)
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 120, height: 60, alignment: .topTrailing)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
