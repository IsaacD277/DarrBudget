//
//  BucketListView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

/*
import SwiftUI
import SwiftData

struct BucketListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    @Query var transactions: [Transaction]
    @Query var paymentMethods: [PaymentMethod]

    @State private var addBucketSheet = false
    @State private var infoSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    VStack(alignment: .leading) {
                        Text(category.name)
                        Text(category.year, format: .number)
                        Text(category.budgeted ?? 0, format: .currency(code: "USD"))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        addBucketSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Details", systemImage: "info.circle") {
                        infoSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $addBucketSheet) {
                addTransactionTEST()
            }
            .sheet(isPresented: $infoSheet) {
                ContentView()
            }
        }
    }
}

#Preview {
    BucketListView()
}

*/
