//
//  CategoryModel.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import Foundation
import SwiftData

@Model
class Category {
    var id: UUID
    var name: String
    var plannedAmount: Double?
    
    init(name: String, plannedAmount: Double? = 0.0) {
        id = UUID()
        self.name = name
        self.plannedAmount = plannedAmount
    }
}

    
