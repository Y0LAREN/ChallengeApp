//
//  NavTitleButton.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 09.02.2025.
//

import SwiftUI
import SwiftData

struct NavTitleButtonModel {
    let buttonImageColor: String
    let buttonBackgroundColor: String
    let buttonImage: String
    let buttonAction: () -> Void
}

struct NavTitleButton: View {
    
    let model: NavTitleButtonModel?
    
    var body: some View {
        Button(action: {
            model?.buttonAction()
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(model?.buttonBackgroundColor ?? "textFieldBackground"))
                    .frame(width: 36, height: 36)
                
                Image(systemName: model?.buttonImage ?? "xmark")
//                    .resizable()
                    .foregroundStyle(Color(model?.buttonImageColor ?? "grayDescription" ))
                    .frame(width: 32, height: 32)
            }
        })
        .frame(width: 36, height: 36)
    }
}

#Preview{
    BadgesView()
}

