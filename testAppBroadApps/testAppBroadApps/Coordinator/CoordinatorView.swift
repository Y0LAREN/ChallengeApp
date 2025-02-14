//
//  CoordinatorView.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 04.02.2025.
//

import SwiftUI

struct CoordinatorView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var coordinator = Coordinator()
    @Environment(\.createCachedDataHandler) private var createDataHandler
    @State var isLoaded = false
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("isReviewerOnboarding") private var isReviewerOnboarding: Bool = false
    @State private var completedChallenge: ChallengeModel?
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            if isLoaded {
                if hasSeenOnboarding {
                    coordinator.build(page: .main)
                        .navigationDestination(for: Page.self) { page in
                            coordinator.build(page: page)
                        }
                        .sheet(item: $coordinator.sheet){ sheet in
                            coordinator.build(sheet: sheet)
                        }
                } else {
                    OnboardingView(isReviewer: isReviewerOnboarding)
                }
            }
            else {
                LoaderView(isLoaded: $isLoaded)
            }
        }
        .environmentObject(coordinator)
    }
}
