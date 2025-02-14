//
//  CachedDataHandler.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 07.02.2025.
//

import SwiftData
import SwiftUI

@ModelActor
actor CachedDataHandler {
    private let statistics = StatisticsManager.shared.getStatistics()
    private let userDefaults = UserDefaults.standard
    
    @MainActor
    public init(modelContainer: ModelContainer, mainActor _: Bool) {
        let modelContext = modelContainer.mainContext
        modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        self.modelContainer = modelContainer
    }
    
    func getFreshChallenge(by id: PersistentIdentifier) throws -> ChallengeModel? {
        let descriptor = FetchDescriptor<ChallengeModel>()
        let allChallenges = try modelContext.fetch(descriptor)
        
        return allChallenges.first(where: { $0.persistentModelID == id })
    }
    
    func updateChallengeProgressIfNeeded(actionForCompletedChallenges: @escaping (ChallengeModel) -> Void) throws {
        let lastUpdate = userDefaults.object(forKey: "lastProgressUpdate") as? Date ?? Date.distantPast
        print("lastUpdate: \(lastUpdate)")
        let calendar = Calendar.current
        
        let activeChallenges = try modelContext.fetch(FetchDescriptor<ChallengeModel>())
        
        guard !(calendar.isDateInToday(lastUpdate)) else {
            print("Челленджи уже обновлены сегодня, пропускаем обновление.")
            for challenge in activeChallenges {
                if challenge.isCompleted {
                    print("Челлендж найден.")
                    actionForCompletedChallenges(challenge)
                }
            }
            return
        }
        
        for challenge in activeChallenges {
            if !challenge.isCompleted {
                challenge.dayProgress += daysBetween(lastUpdate, Date())
                if challenge.dayProgress >= challenge.dayTotal {
                    challenge.isCompleted = true
                    actionForCompletedChallenges(challenge)
                    print("Челлендж найден.")
                }
            }
        }
        
        try modelContext.save()
        userDefaults.set(Date(), forKey: "lastProgressUpdate")
        
        print("`dayProgress` успешно обновлён у всех активных челленджей!")
    }
    
    private func daysBetween(_ startDate: Date, _ endDate: Date) -> Float {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return Float(components.day ?? 0)
    }

        
    func fetchActiveChallenges() throws -> [ChallengeModel] {
        return try modelContext.fetch(FetchDescriptor<ChallengeModel>())
    }
    
    func fetchChallenge(by id: PersistentIdentifier) throws -> ChallengeModel {
        guard let challenge = self[id, as: ChallengeModel.self] else {
            throw NSError(domain: "ChallengeNotFound", code: 404, userInfo: nil)
        }
        return challenge
    }
    
    
    @discardableResult
    func persist(challengeModel: ChallengeModel) throws -> PersistentIdentifier {
        modelContext.insert(challengeModel)
        try modelContext.save()
        StatisticsManager.shared.incrementChallenges()
        StatisticsManager.shared.addDays(1)
        return challengeModel.persistentModelID
    }
    
    func saveContext() throws  {
        try modelContext.save()
    }
    
    @discardableResult
    func changeChallengeProgress(challengeModel: ChallengeModel, dayProgress: Float) throws -> PersistentIdentifier {
        guard let item = self[challengeModel.persistentModelID, as: ChallengeModel.self]
        else {
            return challengeModel.persistentModelID
        }
        if item.dayTotal == dayProgress {
            item.isCompleted = true
        }
        if item.dayProgress > dayProgress {
            StatisticsManager.shared.removeDays(Int(item.dayProgress - dayProgress))
        }
        else if item.dayProgress < dayProgress {
            StatisticsManager.shared.addDays(Int(dayProgress - item.dayProgress))
        }
        item.dayProgress = dayProgress
        try modelContext.save()
        _ = try modelContext.fetch(FetchDescriptor<ChallengeModel>())
        return challengeModel.persistentModelID
    }
    
    @discardableResult
    func restartChallenge(challengeModel: ChallengeModel) throws -> PersistentIdentifier {
        guard let item = self[challengeModel.persistentModelID, as: ChallengeModel.self]
        else {
            return challengeModel.persistentModelID
        }
        item.dayProgress = 0
        item.isCompleted = false
        try modelContext.save()
        _ = try modelContext.fetch(FetchDescriptor<ChallengeModel>())
        return challengeModel.persistentModelID
    }
    
    @discardableResult
    func changeNote(
        noteModel: NoteModel,
        nameNote: String,
        textNote: String,
        emojiNote: String) throws -> PersistentIdentifier {
            guard let item = self[noteModel.persistentModelID, as: NoteModel.self]
            else {
                return noteModel.persistentModelID
            }
                    item.nameNote = nameNote
                    item.textNote = textNote
                    item.emojiNote = emojiNote
            try modelContext.save()
            return noteModel.persistentModelID
        }
    
    @discardableResult
    func persist(noteModel: NoteModel) throws -> PersistentIdentifier {
        modelContext.insert(noteModel)
        try modelContext.save()
        StatisticsManager.shared.incrementNotes()
        return noteModel.persistentModelID
    }
    
    func delete<T: PersistentModel>(id: PersistentIdentifier, ofType type: T.Type) throws {
        guard let item = self[id, as: type] else { return }
        modelContext.delete(item)
        try modelContext.save()
    }
    
    func deleteNote<T: PersistentModel>(id: PersistentIdentifier, ofType type: T.Type, actionAfterDelete: @escaping () -> Void) throws {
        guard let item = self[id, as: type] else { return }
        modelContext.delete(item)
        try modelContext.save()
        actionAfterDelete()
    }
    
    func deleteAllItems<T: PersistentModel>(ofType type: T.Type) throws {
        try modelContext.delete(model: type)
        try modelContext.save()
    }
}

struct CachedDataHandlerKey: EnvironmentKey {
    static let defaultValue: @Sendable @MainActor () async -> CachedDataHandler? = { nil }
}

extension EnvironmentValues {
    var createCachedDataHandler: @Sendable @MainActor () async -> CachedDataHandler? {
        get { self[CachedDataHandlerKey.self] }
        set { self[CachedDataHandlerKey.self] = newValue }
    }
}
