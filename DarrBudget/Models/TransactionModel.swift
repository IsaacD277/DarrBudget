//
//  TransactionModel.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import Foundation
import SwiftData

@Model
class Transaction {
    var id: UUID
    var timestamp: Date
    var name: String
    var date: Date
    var amount: Decimal
    var merchant: String
    var account: String // Will change to Payment model, but currently just simplifying to String
    var notes: String?
    
    @Relationship(inverse: \Bucket.transactions) var bucket: Bucket?
    
    init(name: String, date: Date, amount: Decimal, merchant: String, account: String, bucket: Bucket? = nil, notes: String? = nil) {
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
