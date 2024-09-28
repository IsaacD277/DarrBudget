//
//  ContentView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var text: String = ""
    @FocusState private var isActive: Bool
    
    var body: some View {
        NavigationStack {
            CustomTextFieldWithKeyboard {
                TextField("App Pin Code", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 150)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive)
            } keyboard: {
                CustomNumberKeyboard(inputText: $text, isActive: $isActive, onSubmit: onSubmit)
            }
            .navigationTitle("Custom Keyboard")
        }
    }
    
    func onSubmit() {
        isActive = false
    }
}

#Preview {
    ContentView()
}
