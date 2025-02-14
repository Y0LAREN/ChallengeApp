//
//  NumberOfDays.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 31.01.2025.
//

import SwiftUI

struct NumberOfDays: View {
    let daysLVL: String
    let isActive: Bool
    
    var body: some View {
//        ZStack{
//            Color.background
//                .ignoresSafeArea()
            VStack{
                Text(daysLVL)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.white)
            }
            .frame(width: 72, height: 33)
            .background(isActive ? Color.buttonBlue : Color.textFieldBackground)
            .cornerRadius(6)
//        }
    }
}

#Preview {
    NumberOfDays(
        daysLVL: DaysLVL.data[0].daysString,
        isActive: false)
}
