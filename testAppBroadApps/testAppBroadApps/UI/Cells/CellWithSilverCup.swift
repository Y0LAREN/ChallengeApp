//
//  CellWithSilverCup.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 30.01.2025.
//

import SwiftUI

struct CellWithSilverCup: View {
    let textForCell: String
    let descriptionForCell: String
    
    var body: some View {
//        ZStack{
//            Color.background
//                .ignoresSafeArea()
            VStack{
                ZStack{
                    Image(.elipseSilverCup)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 158, height: 159)
                    
                    Image(.wreath)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 144, height: 141)
                    
                    Image(.cupSolo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 131, height: 127)
                    
                    Image(.cupMask)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 131, height: 127)
                        .blendMode(.color)
                }
                
                Text(textForCell)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.bottom, 5)
                
                Text(descriptionForCell)
                    .foregroundStyle(Color.grayDescription)
                    .font(.system(size: 16))
            }
            .frame(width: 358, height: 299)
            .background(Color.cellBackground)
            .cornerRadius(20)
//        }
    }
}

#Preview {
    CellWithSilverCup(
        textForCell: "Create a challenge",
        descriptionForCell: "Your list of challenges is currently empty")
}
