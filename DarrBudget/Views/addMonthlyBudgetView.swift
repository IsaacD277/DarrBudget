//
//  addMonthlyBudgetView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/10/24.
//

import Foundation
import SwiftUI
import SwiftData

struct addMonthlyBudgetView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    
    @State private var month: Int = 1
    @State private var stringYear: String = "2024"
    @State private var year: Int = 2024
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $month) {
                ForEach(1..<13) { month in
                    Text(month, format: .number)
                }
            }
            
            TextField("Year", text: $stringYear)
                .keyboardType(.numberPad)
                .onChange(of: stringYear) {
                    // Validate input and convert to Double
                    if let value = Int(stringYear) {
                        year = value
                    } else {
                        // Revert to last valid value if input is invalid
                        stringYear = "\(year)"
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .frame(width: 200)
                .background(.fill, in: .rect(cornerRadius: 12))
            
            Button() {
                modelContext.insert(MonthlyBudget(year: year, month: month))
            } label: {
                Text("Add Month")
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 150)
                    .background(.fill, in: .rect(cornerRadius: 12))
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    addMonthlyBudgetView()
}
