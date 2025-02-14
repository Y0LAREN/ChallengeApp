//
//  ChallengeViewModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 07.02.2025.
//


import Foundation
import SwiftData

final class ChallengeViewModel: ObservableObject {
    @Published var challengeModel: ChallengeModel

    init(challengeModel: ChallengeModel) {
        self.challengeModel = challengeModel
    }
}
