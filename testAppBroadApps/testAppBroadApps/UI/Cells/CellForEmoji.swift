//
//  CellForEmotion 2.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 02.02.2025.
//


import SwiftUI

struct CellForEmoji: View {
    let emotion: String
    let isSelected: Bool
    
    var body: some View {
//        ZStack{
//        Color.background
//            .ignoresSafeArea()
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? Color.buttonBlue : Color.emotionRectangle)
                .frame(width: 40, height: 40)
            Image(emotion)
                .resizable()
                .frame(width: 32, height: 32)
        }
//    }
    }
}

#Preview {
    CellForEmoji(
        emotion: Emotion.data[0],
        isSelected: true)
}
