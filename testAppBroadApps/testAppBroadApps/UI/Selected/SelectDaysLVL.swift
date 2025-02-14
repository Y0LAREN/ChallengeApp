//
//  SelectEmotion 2.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 06.02.2025.
//


//
//  SelectEmtion.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 06.02.2025.

import SwiftUI
import SwiftData

struct SelectDaysLVL: View {
    @Binding var selectedLVL: Int?
    let getDaysLVL: (Int) -> Void
    
    var body: some View {
//        ZStack{
//            Color.background
//                .ignoresSafeArea()
        VStack{
            ForEach(0..<3, id: \.self) { index in
                CellForLVLDay(
                    textForCell: DaysLVL.data[index].lvl,
                    lvlForCell: DaysLVL.data[index].daysString,
                    isSelected: selectedLVL == index)
                    .onTapGesture {
                        selectedLVL = index
                        guard let daysLVLIndex = selectedLVL,
                              daysLVLIndex >= 0 && daysLVLIndex < DaysLVL.data.count else { return }
                        getDaysLVL(daysLVLIndex)
                    }
            }
            .padding(.top, 10)
        }
//        }
    }
}

#Preview {
    @Previewable @State var selectedLVL: Int? = nil
    SelectDaysLVL(selectedLVL: $selectedLVL, getDaysLVL: {_ in})
}
