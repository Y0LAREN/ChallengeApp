//
//  AppReviewManager.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 17.02.2025.
//

import SwiftUI
import StoreKit

struct AppReviewManager {
    @MainActor static func requestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if #available(iOS 18.0, *) {
                AppStore.requestReview(in: windowScene)
            } else {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
