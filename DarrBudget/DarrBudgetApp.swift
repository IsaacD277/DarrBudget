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
            addTransactionTEST()
        }
        .modelContainer(for: [PaymentMethod.self, Bucket.self])
    }
}
