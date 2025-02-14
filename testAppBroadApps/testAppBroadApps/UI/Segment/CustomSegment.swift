//
//  Home.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 01.02.2025.
//

import SwiftUI

struct CustomSegment: View {
    
    @Binding var index: Int
    var body: some View {
        
        VStack {
            HStack(spacing: 0){
                HStack{
                    Text("Notes")
                        .foregroundColor(Color.white)
                        .font(self.index == 0 ? .system(size: 13, weight: .bold) : .system(size: 13))
                }
                .frame(height: 24)
                .frame(maxWidth: (.infinity/2))
                .background(self.index == 0 ? Color.darkGraySegment : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .onTapGesture {
                    self.index = 0
                }
                
                HStack{
                    Text("Statistics")
                        .foregroundColor(Color.white)
                        .font(self.index == 1 ? .system(size: 13, weight: .bold) : .system(size: 13))
                    
                }
                .frame(height: 24)
                .frame(maxWidth: (.infinity/2))
                .background(self.index == 1 ? Color.darkGraySegment : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .onTapGesture {
                    self.index = 1
                }
            }
            .frame(height: 28)
            .frame(maxWidth: (.infinity))
            .background(Color.backgroundSegment)
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .padding(.top)
    }
}

#Preview {
    DiaryView()
}
