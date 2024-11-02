//
//  ChipStack.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/1/24.
//

import SwiftUI

struct ChipStack<Content: View>: View {
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
