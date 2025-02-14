//
//  CellSquare.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//

import SwiftUI

struct CellSquare: View {
    let imageForCell: String
    let textForCell: String
    let buttonAction: () -> Void
    var body: some View {
        VStack{
            Image(imageForCell)
                .frame(width: 40, height: 40)
            Text(textForCell)
                .foregroundStyle(Color.white)
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 7)
            Button(action: {
                self.buttonAction()
            }, label: {
                Text("Open")
            })
            .buttonStyle(SmallGrayButton())
            
        }
        .frame(width: 173, height: 152)
        .background(Color.cellBackground)
        .cornerRadius(20)
    }
}

#Preview {
    CellSquare(
        imageForCell: "growthPath",
        textForCell: "My challenges",
        buttonAction: {print("all Good!")})
}
