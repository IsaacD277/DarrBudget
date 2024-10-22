////
////  extensions.swift
////  DarrBudget
////
////  Created by Isaac D2 on 10/21/24.
////
//
//import SwiftUI
//
//extension String {
//    func size(_ font: UIFont) -> CGSize {
//        let attributes = [NSAttributedString.Key.font: font]
//        return self.size(withAttributes: attributes)
//    }
//}
//
//extension ContainerValues {
//    @Entry var viewWidth: CGFloat = 0
//}
//
//extension SubviewsCollection {
//    func chunkByWidth(_ containerWidth: CGFloat) -> [[Subview]] {
//        var row: [Subview] = []
//        var rowWidth: CGFloat = 0
//        var rows: [[Subview]] = []
//        let spacing: CGFloat = 10
//        
//        for subview in self {
//            let viewWidth = subview.containerValues.viewWidth + spacing
//            
//            rowWidth += viewWidth
//            
//            if rowWidth < containerWidth {
//                row.append(subview)
//            } else {
//                rows.append(row)
//                row = [subview]
//                rowWidth = viewWidth
//            }
//        }
//        
//        if !row.isEmpty {
//            rows.append(row)
//        }
//        
//        return rows
//    }
//    
//    func chunked(_ size: Int) -> [[Subview]] {
//        return stride(from: 0, to: count, by: size).map { index in
//            Array(self[index..<Swift.min(index + size, count)])
//        }
//    }
//}

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
    var body: some View {
        NavigationStack {
            VStack {
                ChipsView {
                    ForEach(mockChips) { chip in
                        ChipLabelView(chip: chip)
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

struct ChipLabelView: View {
    var chip: Chip
    
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

#Preview {
    ChipView()
}

struct ChipsView<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        Group(subviews: content) { collection in
            let chunkedCollection = collection.chunkByWidth(350)
            
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
