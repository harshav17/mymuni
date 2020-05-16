//
//  SelectedRoutes.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 5/16/20.
//  Copyright © 2020 Harsha Lingampally. All rights reserved.
//

import Foundation

class PreferedRoutes: ObservableObject {
    @Published var routes = [SRoute]()
}
