//
//  NavTitle.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 09.02.2025.
//

import SwiftUI
import SwiftData

struct NavTitle: View {
    let title: String
    let leadingButtonModel: NavTitleButtonModel
    let trailingButtonModel: NavTitleButtonModel?
    
    
    
    var body: some View {
        HStack(alignment: .center){
            NavTitleButton(model: leadingButtonModel)
            
            Spacer()
            
            Text(title)
                .foregroundStyle(Color.white)
                .font(.system(size: 17, weight: .semibold))
                .multilineTextAlignment(.center)
            Spacer()
            
            if let model = trailingButtonModel
            {
                NavTitleButton(model: model)
            }
            else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 36, height: 36)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}

#Preview{
    BadgesView()
}
