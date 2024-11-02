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
