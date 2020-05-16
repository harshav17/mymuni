//
//  Routes.swift
//  MyMuni
//
//  Created by Harsha Lingampally on 5/16/20.
//  Copyright © 2020 Harsha Lingampally. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum SRoute: Int, Identifiable, CaseIterable {
    case One = 0
    case Seven = 1
    case SevenX = 2
    case Five = 3
    case Eight = 4
    case NineR = 5
    case Nineteen = 6
    case TwentyTwo = 7
    
    var id: SRoute {
        self
    }
    
    var literal: String {
        switch self {
        case .Seven: return "7"
        case .SevenX: return "7X"
        case .One: return "1"
        case .Five: return "5"
        case .Eight: return "8"
        case .NineR: return "9R"
        case .Nineteen: return "19"
        case .TwentyTwo: return "22"
        }
    }
}
