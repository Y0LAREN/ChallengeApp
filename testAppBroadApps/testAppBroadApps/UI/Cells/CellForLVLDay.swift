//
//  CellForLVLDay.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//


import SwiftUI

struct CellForLVLDay: View {
    let textForCell: String
    let lvlForCell: String
    let isSelected: Bool
    
    var body: some View {
//        ZStack{
//            Color.background
//                .ignoresSafeArea()
            HStack{
                Text(textForCell)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .bold))
                    .padding(.leading, 15)
                Spacer()
                NumberOfDays(
                    daysLVL: lvlForCell,
                    isActive: isSelected)
                .padding(.trailing, 15)
            }
            .frame(width: 358, height: 57)
            .background(Color.textFieldBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.buttonBlue : Color.clear, lineWidth: 2)
            )
//        }
    }
}

#Preview {
    CellForLVLDay(
        textForCell: "Easy",
        lvlForCell: "10 days",
        isSelected: true)
}
