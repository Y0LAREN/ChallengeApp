//
//  PageControl.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 03.02.2025.
//

import SwiftUI

struct PageControl: View {
    @Binding var index: Int
    
    var body: some View {
        
//        ZStack{
//            Color.background.ignoresSafeArea()
//            
            HStack(spacing: 5){
                RoundedRectangle(cornerRadius: 19, style: .continuous)
                    .fill(index == 0 ? Color.buttonBlue : Color.emotionRectangle)
                    .frame(width: 36, height: 5)
                RoundedRectangle(cornerRadius: 19, style: .continuous)
                    .fill(index == 1 ? Color.buttonBlue : Color.emotionRectangle)
                    .frame(width: 36, height: 5)
                RoundedRectangle(cornerRadius: 19, style: .continuous)
                    .fill(index == 2 ? Color.buttonBlue : Color.emotionRectangle)
                    .frame(width: 36, height: 5)
            }
//        }
    }
}

#Preview {
    @Previewable @State var index: Int = 0
    PageControl(index: $index)
}
