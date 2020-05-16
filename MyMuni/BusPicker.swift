//
//  BusPicker.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 5/16/20.
//  Copyright © 2020 Harsha Lingampally. All rights reserved.
//

import SwiftUI

struct BusPicker: View {
    @Binding var showRoutesSheet: Bool
    @Binding var favoriteColor: Int
    @ObservedObject var preferedRoutes = PreferedRoutes()
    var body: some View {
        Picker("Length", selection: $favoriteColor) {
            ForEach(self.preferedRoutes.routes, id: \.self) { route in
                Text("\(route.literal)").tag(route.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: 120, height: 25, alignment: .topTrailing)
        .sheet(isPresented: $showRoutesSheet, content: {
            BusList(self.preferedRoutes)
        })
    }
}

//struct BusPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        BusPicker()
//    }
//}
