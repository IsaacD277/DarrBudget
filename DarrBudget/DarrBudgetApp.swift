//
//  DarrBudgetApp.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import SwiftUI

@main
struct DarrBudgetApp: App {
    var body: some Scene {
        WindowGroup {
            addTransactionView()
        }
        .modelContainer(for: [Transaction.self, MonthlyBudget.self])
    }
}
