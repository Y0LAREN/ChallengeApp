//
//  Coordinator.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 28.01.2025.
//

import SwiftUI
import SwiftData

// MARK: - Перечисления для Page и Sheet
enum Page: Hashable, Identifiable {
    case badges
    case challengesList
    case challengeSuccess(dayTotal: Float, goalName: String, modelID: PersistentIdentifier)
    case challengeInfo(model: ChallengeModel)
    case diary
    case editChallenge(model: ChallengeModel)
    case main
    case notesList
    case onboarding
    case settings
    case statistics
    
    var id: String {
        switch self {
            case .badges:
                "badges"
            case .challengesList:
                "challengeList"
            case .challengeSuccess:
                "challengeSuccess"
            case .challengeInfo:
                "challengeInfo"
            case .diary:
                "diary"
            case .editChallenge:
                "editChallenge"
            case .main:
                "main"
            case .notesList:
                "notesList"
            case .onboarding:
                "onboarding"
            case .settings:
                "settings"
            case .statistics:
                "statistics"
        }
    }
}
 
enum Sheet: Identifiable {
    case badgeInfo(model: BadgeModel, isCompleted: Bool)
    case cellForBadges(model: BadgeModel, buttonAction: () -> Void, isCompleted: Bool)
    case createChallenge
    case noteCreate
    case noteInfo(model: NoteModel)
    case noteEdit(model: NoteModel)
    
    var id: String {
        switch self {
            case .badgeInfo:
                return "badgeInfo"
            case .cellForBadges:
                return "cellForBadges"
            case .createChallenge:
                return "createChallenge"
            case .noteCreate:
                return "noteCreate"
            case .noteInfo:
                return "noteInfo"
            case .noteEdit:
                return "noteEdit"
        }
    }
}

//MARK: - Coordinator
final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    
    var modelContext: ModelContext?
    
    func push(_ page: Page){
        path.append(page)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func pop(){
        path.removeLast()
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    func popPenultimate(){
        path.removeLast(path.count - 1)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
            case .badges:
                BadgesView()
            case .challengesList:
                ChallengesListView()
            case .challengeSuccess(let dayTotal, let goalName, let modelID):
                ChallengeSuccessView(dayTotal: dayTotal, goalName: goalName, modelID: modelID)
            case .challengeInfo(let model):
                ChallengeInfoView(model: model)
            case .diary:
                DiaryView()
            case .editChallenge(let model):
                EditChallengeView(model: model)
            case .main:
                MainView()
            case .notesList:
                NotesListView()
            case .onboarding:
                OnboardingView(isReviewer: false)
            case .settings:
                SettingsView()
            case .statistics:
                StatisticsView()
        }
    }
        
    @ViewBuilder
    func start() -> some View {
        if UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
            MainView()
        } else {
            OnboardingView(isReviewer: false) // `true`, если это ревьюер
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
            case .badgeInfo(let model, let isCompleted):
                BadgeInfoView(model: model, isCompleted: isCompleted)
                
            case .cellForBadges(let model, let buttonAction, let isCompleted):
                CellForBadges(model: model, buttonAction: buttonAction, isCompleted: isCompleted)
                
            case .createChallenge:
                CreateChallengeView()
                    .environmentObject(ChallengeViewModel(challengeModel: ChallengeModel(
                        imageForCell: "",
                        goalName: "",
                        dayTotal: 0)))
                
            case .noteCreate:
                NoteCreateView()
                    .environmentObject(createNoteViewModel(noteModel: NoteModel(
                        textNote: "",
                        nameNote: "",
                        emojiNote: "")))
                
            case .noteInfo(let model):
                NoteInfoView(model: model)
            case .noteEdit(let model):
                NoteEditView(model: model)
                
        }
    }
}
//MARK: - Create NoteViewModel
extension Coordinator {
    func createNoteViewModel(noteModel: NoteModel?) -> NoteViewModel {
        if let model = noteModel {
            return NoteViewModel(noteModel: model)
        }

        let newNoteModel = NoteModel(
            textNote: "",
            nameNote: "",
            emojiNote: "")
        return NoteViewModel(noteModel: newNoteModel)
    }
}
