//
//  File.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 27.01.2025.
//

import Foundation
import SwiftUI

struct SmallGrayButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View
    { configuration.label
            .frame(width: 66, height: 34)
            .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
            .background(Color.buttonGray)
            .cornerRadius(50)
            .foregroundStyle(Color.white)
        
    }
    
}
