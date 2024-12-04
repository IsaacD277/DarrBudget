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
    
    @State private var categoryName: String = ""
    @State private var plannedAmount: Double = 0.0
    @State private var stringAmount: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create some budget categories")
                    .font(.title)
                
                TextField("Category Name", text: $categoryName)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 200)
                    .background(.fill, in: .rect(cornerRadius: 12))
                
                TextField("Enter Amount", text: $stringAmount)
                    .keyboardType(.decimalPad)
                    .onChange(of: stringAmount) {
                        // Validate input and convert to Double
                        if let value = Double(stringAmount) {
                            plannedAmount = value
                        } else {
                            // Revert to last valid value if input is invalid
                            stringAmount = "\(plannedAmount)"
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 200)
                    .background(.fill, in: .rect(cornerRadius: 12))
                
                Button() {
                    modelContext.insert(Category(name: categoryName, plannedAmount: plannedAmount))
                    categoryName = ""
                    plannedAmount = 0.0
                } label: {
                    Text("Add Category")
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .frame(width: 150)
                        .background(.fill, in: .rect(cornerRadius: 12))
                }
                .padding(.bottom)
                
                NavigationLink("Next Step", destination: addMonthlyBudgetView())
                    Text("Next Step")
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
    ContentView()
}

/*
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
                // Does nothing
            }
            .padding()
            
            Button("Add Payment Method Data") {
                modelContext.insert(PaymentMethod("Ally"))
                modelContext.insert(PaymentMethod("Apple Card"))
                modelContext.insert(PaymentMethod("Citi"))
                modelContext.insert(PaymentMethod("Discover"))
                modelContext.insert(PaymentMethod("USAA"))
                modelContext.insert(PaymentMethod("Navy Federal"))
                modelContext.insert(PaymentMethod("Other"))
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
*/
