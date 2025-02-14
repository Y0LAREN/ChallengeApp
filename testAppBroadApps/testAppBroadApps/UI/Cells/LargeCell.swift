//
//  LargeCell.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//


import SwiftUI

struct LargeCell: View {
    let imageForCell: String
    let textForCell: String
    let buttonAction: () -> Void
    var body: some View {
//        ZStack{
//            Color.background
            HStack{
                Image(imageForCell)
                    .frame(width: 40, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                Text(textForCell)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Button(action: {
                    self.buttonAction()
                }, label: {
                    Text("Open")
                })
                .buttonStyle(SmallGrayButton())
                .padding(.trailing, 20)
                
            }
            .frame(width: 358, height: 58)
            .background(Color.cellBackground)
            .cornerRadius(20)
//        }
    }
}

#Preview {
    LargeCell(
        imageForCell: "book",
        textForCell: "Diary",
        buttonAction: {print("all Good!")})
}
