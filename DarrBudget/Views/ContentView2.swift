//
//  ContentView2.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/24/24.
//

import SwiftData
import SwiftUI

struct ContentView2: View {
    @Environment(\.modelContext) var modelContext
    @Query var transactions: [Transaction]
    
    @State private var addTransactionSheet: Bool = false
    @State private var addMonthSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            Button("Count Transactions") {
                modelContext.insert(Transaction(name: "Test", date: "10.11.2024", amount: "309.90", merchant: "Speedway", account: "Citi"))
                print("Number of transactions: \(transactions.count)")
            }
            .padding()
            
            ScrollView {
                List {
                    ForEach(transactions) { transaction in
                        HStack {
                            Text(transaction.name)
                                .font(.headline)
                            Spacer()
                            
                            Text("$\(transaction.amount)")
                        }
                    }
                }
                .navigationBarTitle("Transactions")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        addTransactionSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Details", systemImage: "calendar.circle") {
                        addMonthSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $addTransactionSheet) {
                addTransactionView()
            }
            .sheet(isPresented: $addMonthSheet) {
                addMonthlyBudgetView()
            }
        }
    }
}

#Preview {
    ContentView2()
}
