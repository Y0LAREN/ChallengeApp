//
//  StatisticsManager.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 10.02.2025.
//


import Foundation

final class StatisticsManager {
    static let shared = StatisticsManager()

    private let challengesKey = "allChallenges"
    private let daysKey = "totalDays"
    private let notesKey = "totalNotes"
    private let achievementsKey = "totalAchievements"
    private let completedChallengesKey = "completedChallenges"

    private init() {}

//MARK: - Increase
    func addDays(_ days: Int) {
        let current = UserDefaults.standard.integer(forKey: daysKey)
        UserDefaults.standard.set(current + days, forKey: daysKey)
    }

    func incrementChallenges() {
        let current = UserDefaults.standard.integer(forKey: challengesKey)
        UserDefaults.standard.set(current + 1, forKey: challengesKey)
    }
    
    func incrementCompletedChallenges() {
        let current = UserDefaults.standard.integer(forKey: completedChallengesKey)
        UserDefaults.standard.set(current + 1, forKey: completedChallengesKey)
    }
    
    func incrementNotes() {
        let current = UserDefaults.standard.integer(forKey: notesKey)
        UserDefaults.standard.set(current + 1, forKey: notesKey)
    }

    func incrementAchievements() {
        let current = UserDefaults.standard.integer(forKey: achievementsKey)
        UserDefaults.standard.set(current + 1, forKey: achievementsKey)
    }
    
//MARK: - Decrease
    func removeDays(_ days: Int) {
        let current = UserDefaults.standard.integer(forKey: daysKey)
        UserDefaults.standard.set(current - days, forKey: daysKey)
    }

    func decreaseChallenges() {
        let current = UserDefaults.standard.integer(forKey: challengesKey)
        UserDefaults.standard.set(current - 1, forKey: challengesKey)
    }
    
    func decreaseCompletedChallenges() {
        let current = UserDefaults.standard.integer(forKey: completedChallengesKey)
        UserDefaults.standard.set(current + 1, forKey: completedChallengesKey)
    }
    
    func decreaseNotes() {
        let current = UserDefaults.standard.integer(forKey: notesKey)
        UserDefaults.standard.set(current - 1, forKey: notesKey)
    }

    func decreaseAchievements() {
        let current = UserDefaults.standard.integer(forKey: achievementsKey)
        UserDefaults.standard.set(current - 1, forKey: achievementsKey)
    }

    func getStatistics() -> (completedChallenges: Int, totalDays: Int, totalNotes: Int, totalAchievements: Int, allChallenges: Int) {
        return (
            UserDefaults.standard.integer(forKey: challengesKey),
            UserDefaults.standard.integer(forKey: daysKey),
            UserDefaults.standard.integer(forKey: notesKey),
            UserDefaults.standard.integer(forKey: achievementsKey),
            UserDefaults.standard.integer(forKey: completedChallengesKey)
        )
    }
    
    func resetStatistics() {
            UserDefaults.standard.set(0, forKey: challengesKey)
            UserDefaults.standard.set(0, forKey: daysKey)
            UserDefaults.standard.set(0, forKey: notesKey)
            UserDefaults.standard.set(0, forKey: achievementsKey)
            UserDefaults.standard.set(0, forKey: completedChallengesKey)
    }
}
