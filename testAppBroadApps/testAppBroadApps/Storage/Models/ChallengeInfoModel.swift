//
//  ChallengeInfoModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 08.02.2025.
//

import SwiftUI

final class ChallengeInfoModel: ObservableObject{
    @Published var dayProgress: Float
    
    init(dayProgress: Float) {
        self.dayProgress = dayProgress
    }
}
