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
    var account: PaymentMethod // Will change to Payment model, but currently just simplifying to String
    var notes: String?
    
    @Relationship(inverse: \Bucket.transactions) var bucket: Bucket?
    
    init(name: String, date: String, amount: String, merchant: String, account: PaymentMethod, bucket: Bucket? = nil, notes: String? = nil) {
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
