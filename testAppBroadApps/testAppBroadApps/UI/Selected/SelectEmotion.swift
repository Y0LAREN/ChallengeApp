//
//  SelectEmtion.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 06.02.2025.

import SwiftUI
import SwiftData

struct SelectEmotion: View {
    @Binding var selectedEmotion: Int?
    let getEmotion: (Int) -> Void
    
    var body: some View {
//        ZStack{
//            Color.background
//                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Emotion: ")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                .frame(width: 358)
                
                HStack(){
                    ForEach(0..<5, id: \.self) { index in
                        CellForEmotion(
                            emotion: Emotion.data[index],
                            isSelected: selectedEmotion == index)
                        .onTapGesture {
                            selectedEmotion = index
                            guard let emotionIndex = selectedEmotion,
                                  emotionIndex >= 0 && emotionIndex < Emotion.data.count else { return }
                            getEmotion(emotionIndex)
                        }
                    }
                    .padding(.trailing, 12)
                    Spacer()
                }
                .frame(width: 308)
            }
//        }
    }
}

#Preview {
    @Previewable @State var selectedEmotion: Int? = nil
    SelectEmotion(selectedEmotion: $selectedEmotion, getEmotion: {_ in })
}
