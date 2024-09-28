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

    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                ContentView()
            }
            
            List {
                ForEach(buckets) { bucket in
                    VStack(alignment: .center) {
                        Text(bucket.name)
                        Text(bucket.month.description)
                        Text(bucket.year, format: .number)
                        Text(bucket.budgeted ?? 0, format: .currency(code: "USD"))
                    }
                }
            }
            .toolbar {
                Button("Add Bucket") {
                    addBucketData()
                }
            }
        }
    }
    
    func addBucketData() {
        let newBucket = Bucket(name: "Test", month: 10, year: 2024, budgeted: 50.0)
        
        modelContext.insert(newBucket)
    }
}

#Preview {
    BucketListView()
}
