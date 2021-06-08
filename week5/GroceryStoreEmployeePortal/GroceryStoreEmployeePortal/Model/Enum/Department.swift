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
        
    var taskDescription: String {
        switch self {
        case .bakery:
            return "Bake a cake"
        case .produce:
            return "Inspect fruit for freshness"
        }
    }
    
    var taskImage: UIImage? {
        switch self {
        case .bakery:
            return UIImage(named: "cake")
        case .produce:
            return UIImage(named: "grapes")
        }
    }
}
