//
//  ChipView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 10/21/24.
//

import SwiftUI

struct ChipView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ChipsView {
                    ForEach(mockChips) { chip in
                        let viewWidth = chip.name.size(.preferredFont(forTextStyle: .body)).width + 20
                        
                        Text(chip.name)
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(.red.gradient, in: .capsule)
                            .containerValue(\.viewWidth, viewWidth)
                    }
                }
                .frame(width: 300)
                .padding(15)
                .background(.primary.opacity(0.06, in: .rect(cornerRadius: 101)))
            }
            .padding(15)
            .navigationTitle("Chips")
        }
    }
}

extension String {
    func size(_ font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes)
    }
}

extension ContainerValues {
    @Entry var viewWidth: CGFloat = 0
}

#Preview {
    ChipView()
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

extension SubviewsCollection {
    func chunkByWidth(_ containerWidth: CGFloat) -> [[Subview]] {
        var row: [Subview] = []
        var rowWidth: CGFloat = 0
        var rows: [[Subview]] = []
        var spacing: CGFloat = 10
        
        for subview in self {
            let viewWidth = subview.containerValues.viewWidth + spacing
            
            rowWidth += viewWidth
            
            if rowWidth > containerWidth {
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
