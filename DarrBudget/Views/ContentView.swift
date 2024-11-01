//
//  ContentView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var text: String = ""
    @FocusState private var isActive: Bool
    
    var body: some View {
        NavigationStack {
            CustomTextFieldWithKeyboard {
                TextField("App Pin Code", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 150)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive)
            } keyboard: {
                CustomNumberKeyboard(inputText: $text, isActive: $isActive, onSubmit: onSubmit)
            }
            
            Button("Get SQLite Command") {
                print(modelContext.sqliteCommand)
            }
            .padding()
            
            Button("Add Bucket Data") {
                modelContext.insert(Bucket(name: "Test", month: 9, year: 2024))
                modelContext.insert(Bucket(name: "Quiz", month: 9, year: 2024))
                modelContext.insert(Bucket(name: "Exam", month: 9, year: 2024))
            }
            .padding()
            
            Button("Add Payment Method Data") {
                modelContext.insert(Payment(name: "Ally"))
                modelContext.insert(Payment(name: "Apple Card"))
                modelContext.insert(Payment(name: "Citi"))
                modelContext.insert(Payment(name: "Discover"))
                modelContext.insert(Payment(name: "USAA"))
                modelContext.insert(Payment(name: "Navy Federal"))
                modelContext.insert(Payment(name: "Other"))
            }
            
            .navigationTitle("Custom Keyboard")
        }
    }
    
    func onSubmit() {
        isActive = false
    }
}

#Preview {
    ContentView()
}
