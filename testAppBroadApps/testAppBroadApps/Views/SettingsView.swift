//
//  SettingsView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 03.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.createCachedDataHandler) private var createDataHandler
    
    private let statistics = StatisticsManager.shared.getStatistics()
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                NavTitle(
                    title: "Settings",
                    leadingButtonModel: NavTitleButtonModel(
                        buttonImageColor: "grayDescription",
                        buttonBackgroundColor: "textFieldBackground",
                        buttonImage: "xmark",
                        buttonAction: {
                            coordinator.pop()
                        }),
                    trailingButtonModel: nil)
                
                SettingCell(
                    imageForCell: "square.and.arrow.up.fill",
                    textForCell: "Share our app",
                    isBlue: true,
                    buttonTitle: "Share",
                    buttonAction: {
                        shareApp(link: Links.shareAppLink)
                    })
                SettingCell(
                    imageForCell: "star.square.fill",
                    textForCell: "Rate us",
                    isBlue: true,
                    buttonTitle: "Rate",
                    buttonAction: {
                        AppReviewManager.requestReview()
                    })
                SettingCell(
                    imageForCell: "person.badge.shield.checkmark.fill",
                    textForCell: "Usage Policy",
                    isBlue: true,
                    buttonTitle: "Read",
                    buttonAction: {
                        openPrivacyPolicy(link: Links.usagePolicyLink)
                    })
                SettingCell(
                    imageForCell: "trash.square.fill",
                    textForCell: "Reset progress",
                    isBlue: false,
                    buttonTitle: "Reset",
                    buttonAction: {
                        resetProgress()
                    })
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            
        }
    }
    
    private func resetProgress(){
        StatisticsManager.shared.resetStatistics()
        deleteChallenges()
        deleteNotes()
    }
    
    @MainActor
    private func deleteChallenges() {
        Task {
            if let dataHandler = await createDataHandler() {
                    do {
                        try await dataHandler.deleteAllItems(ofType: ChallengeModel.self)
                    } catch {
                        debugPrint("ERROR OCCURRED WHILE DELETING DIARY ENTRY - \(error)")
                    }
            }
        }
    }
    
    @MainActor
    private func deleteNotes() {
        Task {
            if let dataHandler = await createDataHandler() {
                    do {
                        try await dataHandler.deleteAllItems(ofType: NoteModel.self)
                    } catch {
                        debugPrint("ERROR OCCURRED WHILE DELETING DIARY ENTRY - \(error)")
                    }
            }
        }
    }
    
    private func shareApp(link: String) {
        guard let url = URL(string: link) else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    private func openPrivacyPolicy(link: String) {
        guard let url = URL(string: link) else {
            print("Неверный URL")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}

#Preview {
    SettingsView()
}
