//
//  DynamicQuery.swift
//  DarrBudget
//
//  Created by Isaac D2 on 11/1/24.
//

import SwiftData
import SwiftUI

struct DynamicQuery<Element: PersistentModel, Content: View>: View {
    let descriptor: FetchDescriptor<Element>
    let content: ([Element]) -> Content
    
    @Query var items: [Element]
    
    init(_ descriptor: FetchDescriptor<Element>, @ViewBuilder content: @escaping ([Element]) -> Content) {
        self.descriptor = descriptor
        self.content = content
        _items = Query(descriptor)
    }
    
    var body: some View {
        content(items)
    }
}
