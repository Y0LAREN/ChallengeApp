//
//  CustomPlaceholderTextField.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 31.01.2025.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var inputText: String
    @State var placeholder: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if inputText.isEmpty {
                Text(placeholder)
                    .foregroundColor(.grayPlaceholder)
                    .padding(.leading, 8)
            }
            
            TextField(placeholder, text: $inputText)
                .frame(width: 356, height: 56)
                .padding(.leading, 8)
                .background(Color.textFieldBackground)
                .foregroundStyle(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isFocused ? Color.buttonBlue : Color.textFieldBorder, lineWidth: 2)
                )
        }
        .focused($isFocused)
        .onTapGesture {
            isFocused = true
        }
        .onDisappear {
            isFocused = false
        }
        .cornerRadius(16)
    }
}


