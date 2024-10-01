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
    
    @FocusState private var isActive: Bool
    
    @State private var name: String = ""
    @State private var selectedDate: Date = Date.now
    @State private var budgetedAmount: Double = 0.0
    
    var body: some View {
        NavigationStack {
            TextField("Bucket Name", text: $name)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .frame(width: 150)
                .background(.fill, in: .rect(cornerRadius: 12))
                .focused($isActive)
            
            YearMonthPickerView(selectedDate: $selectedDate)
            
            Button {
                onSubmit()
            } label: {
                Text("Add Bucket")
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 150)
                    .background(.blue, in: .rect(cornerRadius: 12))
            }
        }
    }
    
    func onSubmit() {
        let selectedMonth = Calendar.current.component(.month, from: selectedDate)
        let selectedYear = Calendar.current.component(.year, from: selectedDate)
        let newBucket = Bucket(name: name, month: selectedMonth, year: selectedYear)
        modelContext.insert(newBucket)
        
        isActive = false
        dismiss()
    }
}

#Preview {
    AddBucketView()
}
