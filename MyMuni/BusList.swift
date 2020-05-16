//
//  BusListView.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 5/15/20.
//  Copyright © 2020 Harsha Lingampally. All rights reserved.
//

import Foundation
import SwiftUI

struct BusList: View {
    @State private var selections = [SRoute]()
    @ObservedObject var preferedRoutes: PreferedRoutes
    
    init(_ preferedRoutes: PreferedRoutes) {
        self.preferedRoutes = preferedRoutes
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Choose prefered routes")) {
                    ForEach(SRoute.allCases) { item in
                        BusRow(title: item.literal, isSelected: self.selections.contains(item)) {
                            if self.selections.contains(item) {
                                self.selections.removeAll(where: { $0 == item })
                            } else {
                                self.selections.append(item)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: { self.selections = self.preferedRoutes.routes})
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Routes", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.preferedRoutes.routes = self.selections
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("OK")
                }
            )
        }
    }
}

//struct BusList_Previews: PreviewProvider {
//    static var previews: some View {
//        BusList()
//    }
//}
