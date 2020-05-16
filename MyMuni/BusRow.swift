//
//  BusRow.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 5/15/20.
//  Copyright © 2020 Harsha Lingampally. All rights reserved.
//

import Foundation
import SwiftUI

struct BusRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark").foregroundColor(.blue)
                }
            }
        }.foregroundColor(Color.black)
    }
}

//struct BusRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusRow()
//    }
//}
