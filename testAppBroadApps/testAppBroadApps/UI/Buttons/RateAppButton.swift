//
//  RateAppButton.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 17.02.2025.
//


import SwiftUI
import StoreKit

struct RateAppButton: View {
    var body: some View {
        Button(action: {
            requestReviewManually()
        }) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("Оценить приложение")
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
        }
    }

    private func requestReviewManually() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            AppStore.requestReview(in: windowScene)
        }
    }
}
