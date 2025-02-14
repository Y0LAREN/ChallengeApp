//
//  MainButton.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//


import Foundation
import SwiftUI

struct MainButton: ButtonStyle {
    
    @State var frameWidth: CGFloat
    @State var frameHeight: CGFloat
    @State var buttonColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View
    { configuration.label
            .frame(width: frameWidth, height: frameHeight)
            .background(buttonColor)
            .foregroundStyle(Color.white)
            .cornerRadius(12)
    }
    
}