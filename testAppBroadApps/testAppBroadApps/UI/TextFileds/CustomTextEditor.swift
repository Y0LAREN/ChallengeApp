//
//  CustomTextField 2.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 02.02.2025.
//


//
//  CustomPlaceholderTextField.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 31.01.2025.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var inputText: String
    @State var placeholder: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if inputText.isEmpty {
                VStack{
                    HStack{
                        Text(placeholder)
                            .foregroundColor(.grayPlaceholder)
                            .padding(.leading, 8)
                            .padding(.top, 8)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 356, height: 142)
            }
            TextEditor(text: $inputText)
                .frame(width: 356, height: 142)
                .padding(.leading, 8)
                .scrollContentBackground(.hidden)
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


#Preview {
    NoteCreateView()
}
