//
//  SelectEmoji.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 02.02.2025.
//

import SwiftUI

///Используется как для создания, так и для редактирования!
struct SelectEmoji: View {
    @Binding var selectedEmoji: Int?
    let getEmoji: (Int) -> Void
    
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
                
                HStack{
                    HStack{
                        ForEach(0..<Emoji.data.count, id: \.self) { index in
                            CellForEmoji(
                                emotion: Emoji.data[index],
                                isSelected: selectedEmoji == index)
                            .onTapGesture {
                                selectedEmoji = index
                                guard let emojiIndex = selectedEmoji,
                                      emojiIndex >= 0 && emojiIndex < Emoji.data.count else { return }
                                getEmoji(emojiIndex)
                            }
                        }
                        .padding(.trailing, 12)
                        Spacer()
                    }
                    .frame(width: 308)
                    Spacer()
                }
            }
            .frame(width: 358)
//        }
    }
}

#Preview {
    @Previewable @State var selectedEmoji: Int? = nil
    SelectEmoji(selectedEmoji: $selectedEmoji, getEmoji: {_ in})
}
