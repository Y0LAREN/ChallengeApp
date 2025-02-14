//
//  BadgeViewModel.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 07.02.2025.
//

import Foundation
import SwiftData

final class BadgeViewModel: ObservableObject {
    @Published var badgeViewModel: BadgeViewModel

    init(badgeViewModel: BadgeViewModel) {
        self.badgeViewModel = badgeViewModel
    }
}
