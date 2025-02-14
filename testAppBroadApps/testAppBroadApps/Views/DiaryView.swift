//
//  DiaryView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 01.02.2025.
//

import SwiftUI

struct DiaryView: View {
    @State private var index: Int = 0
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack{
            switch index{
                case 0:
                    Color.background
                        .ignoresSafeArea()
                case 1:
                    ZStack{
                        Color.background
                            .ignoresSafeArea()
                        Image(.backgroundDiary)
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                    }
                default:
                    Color.background
                        .ignoresSafeArea()
            }
            VStack{
                NavTitle(
                    title: "Diary",
                    leadingButtonModel: NavTitleButtonModel(
                        buttonImageColor: "grayDescription",
                        buttonBackgroundColor: "textFieldBackground",
                        buttonImage: "xmark",
                        buttonAction: {
                            coordinator.pop()
                        }),
                    trailingButtonModel: nil)
                
                HStack{
                    Text("Record observations to improve your score. Clear planning is the key to achieving your goals!")
                        .frame(height: 36)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.init(white: 0.5))
                        .font(.system(size: 13))
                    Spacer()
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.diaryTextBackground)
                .cornerRadius(20)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                
                CustomSegmentView(index: $index)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DiaryView()
}
