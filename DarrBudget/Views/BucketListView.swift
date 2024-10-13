//
//  BucketListView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import SwiftUI
import SwiftData

struct BucketListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var buckets: [Bucket]

    @State private var addBucketSheet = false
    @State private var infoSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(buckets) { bucket in
                    VStack(alignment: .leading) {
                        Text(bucket.name)
                        Text(bucket.month.description)
                        Text(bucket.year, format: .number)
                        Text(bucket.budgeted ?? 0, format: .currency(code: "USD"))
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
                addTransactionView()
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
