//
//  MonthlyBudgetModel.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/10/24.
//

import Foundation
import SwiftData

@Model
class MonthlyBudget {
    var id: UUID
    var year: Int
    var month: Int
//    var categories: [Category]  // The budget targets for this month
//    var transactions: [Transaction]  // Actual transactions for this month
    
    init(year: Int, month: Int) {
        id = UUID()
        self.year = year
        self.month = month
    }
}
