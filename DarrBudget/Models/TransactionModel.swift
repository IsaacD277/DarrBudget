//
//  TransactionModel.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Transaction {
    var id: UUID
    var timestamp: Date
    var name: String
    var date: String
    var amount: String
    var merchant: String
    var account: String // Will change to Payment model, but currently just simplifying to String
    var notes: String?
    
    @Relationship(inverse: \Bucket.transactions) var bucket: Bucket?
    
    init(name: String, date: String, amount: String, merchant: String, account: String, bucket: Bucket? = nil, notes: String? = nil) {
        id = UUID()
        timestamp = Date.now
        self.name = name
        self.date = date
        self.amount = amount
        self.merchant = merchant
        self.account = account
        self.bucket = bucket
        self.notes = notes
    }
}

struct ContentViews: View {
    @Query var transactions: [Transaction]
    @State private var csvURL: URL?

    var body: some View {
        VStack {
            Button("Export CSV") {
                exportCSV()
            }
            .padding()
            // .disabled(csvURL == nil) // Disable if there's no CSV to share
            
            // ShareLink for exporting
            if let csvURL = csvURL {
                ShareLink(item: csvURL) {
                    Text("Share CSV")
                }
            }
        }
    }

    func exportCSV() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        // Header row
        var csvData = [["Date", "Amount", "Merchant", "Account", "Bucket", "Notes"]]
        
        // Append each transaction as a row
        for transaction in transactions {
            let row: [String] = [
                transaction.date, // .formatted(.dateTime.month().day().year()),
                transaction.amount, //.formatted(),
                transaction.merchant,
                transaction.account,
                transaction.bucket?.name ?? "",
                transaction.notes ?? ""
            ]
            csvData.append(row)
        }
        
        // Join rows into CSV format
        let csvString = csvData.map { $0.joined(separator: ",") }.joined(separator: "\n")

        // Save to temporary directory
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("ExportedTransactions.csv")

        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            csvURL = fileURL
        } catch {
            print("Error writing CSV file: \(error)")
        }
    }
}
