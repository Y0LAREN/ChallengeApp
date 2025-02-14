//
//  LargeCell 2.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 03.02.2025.
//


//
//  LargeCell.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//


import SwiftUI

struct SettingCell: View {
    let imageForCell: String
    let textForCell: String
    let isBlue: Bool
    let buttonTitle: String
    let buttonAction: () -> Void
    var body: some View {
//        ZStack{
//            Color.background
            HStack{
                Image(systemName: imageForCell)
                    .foregroundStyle(isBlue ? Color.buttonBlue : Color.buttonRed)
                    .frame(width: 40, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                Text(textForCell)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button(action: {
                    self.buttonAction()
                }, label: {
                    Text(buttonTitle)
                })
                .buttonStyle(SmallGrayButton())
                .padding(.trailing, 20)
                
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(Color.cellBackground)
            .cornerRadius(20)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
//        }
    }
}

#Preview {
    LargeCell(
        imageForCell: "book",
        textForCell: "Diary",
        buttonAction: {print("all Good!")})
}
