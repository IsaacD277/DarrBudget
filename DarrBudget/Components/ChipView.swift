//
//  ChipView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/1/24.
//

import SwiftData
import SwiftUI

struct ChipView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var accounts: [PaymentMethod]
    
    var body: some View {
        ChipStack {
            ForEach(accounts) { payment in
                ChipLabelView(chip: payment)
            }
        }
        .frame(width: 350)
        .padding(15)
        .background(.primary.opacity(0.06), in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ChipView()
}
