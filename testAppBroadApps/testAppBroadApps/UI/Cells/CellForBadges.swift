//
//  CellSquare 2.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//


import SwiftUI

struct CellForBadges: View {
    @State var model: BadgeModel
    @State var buttonAction: ()-> Void
    let isCompleted: Bool
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                ZStack{
                    
                    Image(model.imageBadge)
                        .frame(width: 100, height: 100)
                    if !isCompleted{
                        Image(model.imageBadgeMask)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .blendMode(.color)
                    }
                }
                
                Text(model.labelText)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 13, weight: .bold))
                    .padding(.bottom, 10)
                Button(action: {
                    buttonAction()
                }, label: {
                    Text("Info")
                })
                .buttonStyle(SmallGrayButton())
                
            }
            .frame(height: 208)
            .frame(maxWidth: .infinity)
            .background(Color.cellBackground)
            .cornerRadius(20)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        }
    }
}

#Preview {
    CellForBadges(
        model: BadgeModel(
            imageBadge: "badgeCup",
            imageBadgeMask: "badgeCupMask",
            labelText: "Five steps to success",
            descriptionText: ""),
        buttonAction: {},
        isCompleted: true)
}
