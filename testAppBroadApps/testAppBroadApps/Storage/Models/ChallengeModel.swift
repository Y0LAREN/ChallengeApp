//
//  ChallengeModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 05.02.2025.
//

import SwiftUI
import SwiftData

@Model
final class ChallengeModel: Hashable, Identifiable, ObservableObject{
    @Attribute(.unique) var id = UUID()
    var imageForCell: String
    var goalName: String
    var dayTotal: Float
    var dayProgress: Float = 1
    var isCompleted: Bool = false
    
    init(imageForCell: String, goalName: String, dayTotal: Float, dayProgress: Float = 1) {
        self.imageForCell = imageForCell
        self.goalName = goalName
        self.dayTotal = dayTotal
        self.dayProgress = dayProgress
        self.isCompleted = false
        
    }
}
