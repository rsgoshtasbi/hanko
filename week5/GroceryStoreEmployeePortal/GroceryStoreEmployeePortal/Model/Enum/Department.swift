//
//  Department.swift
//  GroceryStoreEmployeePortal
//
//  Created by Rashid Goshtasbi on 6/1/21.
//

import Foundation
import UIKit

enum Department {
    case bakery
    case produce
    
    var title: String {
        switch self {
        case .bakery:
            return "Bakery Department"
        case .produce:
            return "Produce Department"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .bakery:
            return UIImage(named: "bread")
        case .produce:
            return UIImage(named: "apple")
        }
    }
    
    var task: String {
        switch self {
        case .bakery:
            return "Daily Task: Bake a cake"
        case .produce:
            return "Daily Task: Bake a cake"
        }
    }
}
