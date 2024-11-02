//
//  ChipLabelView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/1/24.
//

import SwiftUI

struct ChipLabelView: View {
    var chip: PaymentMethod
    
    var body: some View {
        let viewWidth = chip.name.size(.preferredFont(forTextStyle: .body)).width + 20
        
        Text(chip.name)
            .font(.body)
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.blue.gradient, in: Capsule())
            .containerValue(\.viewWidth, viewWidth)
    }
}

#Preview {    
    ChipLabelView(chip: .init("Test"))
}
