//
//  testAppBroadAppsApp.swift
//  testAppBroadApps
//
//  Created by Илья Иванов on 27.01.2025.
//

import SwiftUI
import SwiftData

@main
struct testAppBroadAppsApp: App {
    private let dataProvider = CachedDataProvider.shared
    private let dataHandler: CachedDataHandler

    init() {
        self.dataHandler = CachedDataHandler(modelContainer: dataProvider.sharedModelContainer)
    }

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(\.createCachedDataHandler, dataProvider.createCachedDataHandler())
        }
        .modelContainer(dataProvider.sharedModelContainer)
    }
}
