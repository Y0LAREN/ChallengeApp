//
//  StatisticsModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 05.02.2025.
//


import SwiftUI
import SwiftData

@Model
final class StatisticsModel: Hashable, Identifiable{
    var daysInChallenge: Int
    var entriesAdded: Int
    var achievementsReceived: Int
    var allChallenges: Int
    var completedChallenges: Int
    
    init(daysInChallenge: Int, entriesAdded: Int, achievementsReceived: Int, allChallenges: Int, completedChallenges: Int) {
        self.daysInChallenge = daysInChallenge
        self.entriesAdded = entriesAdded
        self.achievementsReceived = achievementsReceived
        self.allChallenges = allChallenges
        self.completedChallenges = completedChallenges
    }
}
