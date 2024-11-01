//
//  Extensions.swift
//  
//
//  Created by Isaac D2 on 10/22/24.
//

import SwiftData
import SwiftUI

extension String {
    func size(_ font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes)
    }
}

extension ContainerValues {
    @Entry var viewWidth: CGFloat = 0
}

extension SubviewsCollection {
    func chunkByWidth(_ containerWidth: CGFloat) -> [[Subview]] {
        var row: [Subview] = []
        var rowWidth: CGFloat = 0
        var rows: [[Subview]] = []
        let spacing: CGFloat = 10
        
        for subview in self {
            let viewWidth = subview.containerValues.viewWidth + spacing
            
            rowWidth += viewWidth
            
            if rowWidth < containerWidth {
                row.append(subview)
            } else {
                rows.append(row)
                row = [subview]
                rowWidth = viewWidth
            }
        }
        
        if !row.isEmpty {
            rows.append(row)
        }
        
        return rows
    }
    
    func chunked(_ size: Int) -> [[Subview]] {
        return stride(from: 0, to: count, by: size).map { index in
            Array(self[index..<Swift.min(index + size, count)])
        }
    }
}

struct ChipView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var accounts: [Payment]
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Add Payment Method Data") {
                    modelContext.insert(Payment(name: "Ally"))
                    modelContext.insert(Payment(name: "Apple Card"))
                    modelContext.insert(Payment(name: "Citi"))
                    modelContext.insert(Payment(name: "Discover"))
                    modelContext.insert(Payment(name: "USAA"))
                    modelContext.insert(Payment(name: "Navy Federal"))
                    modelContext.insert(Payment(name: "Other"))
                }
                
                ChipsView {
                    ForEach(accounts) { payment in
                        ChipLabelView(chip: payment)
                    }
                }
                .frame(width: 350)
                .padding(15)
                .background(.primary.opacity(0.06), in: RoundedRectangle(cornerRadius: 10))
            }
            .padding(15)
            .navigationTitle("Chips")
        }
    }
}

#Preview {
    ChipView()
}

struct ChipLabelView: View {
    var chip: Payment
    
    var body: some View {
        let viewWidth = chip.name.size(.preferredFont(forTextStyle: .body)).width + 20
        
        Text(chip.name)
            .font(.body)
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(Color.red.gradient, in: Capsule())
            .containerValue(\.viewWidth, viewWidth)
    }
}

struct ChipsView<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        Group(subviews: content) { collection in
            let chunkedCollection = collection.chunkByWidth(300)
            
            VStack(alignment: .center, spacing: 10) {
                ForEach(chunkedCollection.indices, id: \.self) { index in
                    HStack(spacing: 10) {
                        ForEach(chunkedCollection[index]) { subview in
                            subview
                        }
                    }
                }
            }
        }
    }
}

// Mock Data
struct Chip: Identifiable {
    var id: String = UUID().uuidString
    var name: String
}

var mockChips: [Chip] = [
    .init(name: "Apple"),
    .init(name: "Banana"),
    .init(name: "Orange"),
    .init(name: "Pineapple"),
    .init(name: "Strawberry"),
    .init(name: "Watermelon"),
    .init(name: "Kiwi"),
    .init(name: "Grapefruit"),
    .init(name: "Cherry"),
    .init(name: "Blueberry"),
    .init(name: "Pomegranate"),
    .init(name: "Mango")
]
