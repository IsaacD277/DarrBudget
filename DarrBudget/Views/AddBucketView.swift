//
//  AddBucketView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/28/24.
//

import SwiftData
import SwiftUI

struct AddBucketView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date.now)
    @State private var selectedYear = Calendar.current.component(.year, from: Date.now)
    @State private var budgetedAmount: Double = 0.0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear() {
                print(selectedYear.customMirror.subjectType)
            }
    }
}

#Preview {
    AddBucketView()
}
