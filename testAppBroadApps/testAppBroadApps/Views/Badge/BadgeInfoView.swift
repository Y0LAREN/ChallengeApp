//
//  BadgeInfoView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 29.01.2025.
//

import SwiftUI
import SwiftData

struct BadgeInfoView: View {
    let model: BadgeModel
    let isCompleted: Bool
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                Image(.elipseBigBadge)
                    .frame(width: 419, height: 419)
                Spacer()
            }
            .padding(.top, 30)
            VStack{
                NoteNavTitle(nameNote: "Badge")
                
                ZStack{
                    Image(model.imageBadge)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                    
                    if !isCompleted{
                        Image(model.imageBadgeMask)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .blendMode(.color)
                    }
                }
                .padding(.top, 60)
                
                Text(model.labelText)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 6)
                Text(model.descriptionText)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.grayDescription)
                Spacer()
                Button(action: {
                    self.coordinator.dismissSheet()
                }, label: {
                    HStack{
                        switch !isCompleted{
                            case true:
                                Text("Done")
                            case false:
                                Image(systemName: "checkmark")
                                    .mask({
                                        Image(.badge1Mask)
                                    })
                                Text("Executed by")
                        }
                    }
                })
                .buttonStyle(MainButton(
                    frameWidth: 358,
                    frameHeight: 56,
                    buttonColor: .buttonBlue))
                
            }
        }
        .navigationTitle("Badge")
    }
}

#Preview {
    BadgeInfoView(model: BadgeModel(
        imageBadge: "badge1",
        imageBadgeMask: "badge1Mask",
        labelText: "First victory",
        descriptionText: "Exercise: complete 1 challenge!"),
                  isCompleted: false)
}
