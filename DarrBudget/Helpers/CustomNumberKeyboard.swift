//
//  CustomNumberKeyboard.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/28/24.
//

import SwiftUI

struct CustomNumberKeyboard: View {
    let rows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "<"]
    ]
    
    @Binding var inputText: String
    @FocusState.Binding var isActive: Bool
    @State private var tappedKey: String?
    
    var onSubmit: () -> Void // Pass in the submit action
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(row, id: \.self) { key in
                        KeyButton(key: key, inputText: $inputText, tappedKey: $tappedKey, isActive: $isActive, onSubmit: onSubmit)
                    }
                }
            }
        }
        .padding()
    }
}

struct KeyButton: View {
    var key: String
    @Binding var inputText: String
    @Binding var tappedKey: String?
    @FocusState.Binding var isActive: Bool
    var onSubmit: () -> Void

    var body: some View {
        Button(action: {
            tappedKey = key
            handleKeyAction()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                tappedKey = nil
            }
        }) {
            buttonContent
        }
        .scaleEffect(tappedKey == key ? 1.2 : 1.0)
        .animation(.bouncy, value: tappedKey)
    }

    @ViewBuilder
    var buttonContent: some View {
        if key == "<" {
            Image(systemName: "delete.left")
                .font(.largeTitle)
                .fontWeight(.black)
                .frame(width: 115, height: 75)
                .foregroundColor(.blue)
        } else if key == ">" {
            Image(systemName: "arrowshape.right")
                .font(.largeTitle)
                .fontWeight(.black)
                .frame(width: 115, height: 75)
                .foregroundColor(.blue)
        } else {
            Text(key)
                .font(.largeTitle)
                .fontWeight(.black)
                .frame(width: 115, height: 75)
                .foregroundColor(.blue)
        }
    }

    func handleKeyAction() {
        if key == "<", !inputText.isEmpty {
            inputText.removeLast()  // Deletes the last character
        } else if key == ">", !inputText.isEmpty {
            onSubmit()  // Trigger submit action
            isActive = false  // Unfocus the custom keyboard
        } else if Double(inputText + key) != nil {
            inputText += key  // Append number key to input text
        }
    }
}

#Preview {
    ContentView()
}
