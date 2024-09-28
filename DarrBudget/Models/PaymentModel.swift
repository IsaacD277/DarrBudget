//
//  PaymentModel.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import Foundation
import SwiftData

@Model
class Payment {
    var id: UUID
    var name: String
    
    init(name: String) {
        id = UUID()
        self.name = name
    }
}
