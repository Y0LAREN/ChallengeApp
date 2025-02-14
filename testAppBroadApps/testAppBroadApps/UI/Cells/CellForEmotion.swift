//
//  CellForEmotion.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 31.01.2025.
//

import SwiftUI

struct CellForEmotion: View {
    let emotion: String
    let isSelected: Bool
    
    var body: some View {
//        ZStack{
//        Color.background
//            .ignoresSafeArea()
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? Color.buttonBlue : Color.emotionRectangle)
                .frame(width: 52, height: 52)
            Image(emotion)
                .resizable()
                .frame(width: 48, height: 48)
        }
//    }
    }
}

#Preview {
    CellForEmotion(
        emotion: Emotion.data[0],
        isSelected: true)
}
