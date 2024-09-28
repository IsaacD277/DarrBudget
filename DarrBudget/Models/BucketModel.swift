//
//  BucketModel.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import Foundation
import SwiftData

@Model
class Bucket {
    var id: UUID
    var name: String
    var month: Int
    var year: Int
    var budgeted: Double?
//    var previousMonth: Double? // Pull from the previous month somehow
//    var spent: Double? // Calculated from Transactions
//    var remaining: Double? // Calculated from budgeted, previousMonth, and spent
    
    @Relationship(deleteRule: .cascade) var transactions = [Transaction]()
    
    init(name: String, month: Int, year: Int, budgeted: Double? = nil) {
        id = UUID()
        self.name = name
        self.month = month
        self.year = year
        self.budgeted = budgeted
    }
}


// Quick Bucket model to pull for previews
extension Bucket {
    static var dummy: Bucket {
        .init(name: "Gas", month: 10, year: 2024)
    }
}

    
