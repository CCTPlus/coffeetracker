//
//  CoffeeTrackerApp.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 2/21/22.
//

/*
 Supporters:
 MikaelaCaron
 */

import SwiftUI
import RevenueCat
import TelemetryDeck

@main
struct CoffeeTrackerApp: App {
    @State private var beansVM: BeansCollectionViewOO?
    @State private var reviewPrompt = ReviewPromptService()

    @State private var showingLaunchAnimation: Bool = {
        #if DEBUG
        return !ScreenshotSampleData.isEnabled
        #else
        return true
        #endif
    }()

    init() {
        // TelemetryDeck has to be initialized first so RevenueCat gets the hashed user ID
        Analytics.configure()

        Purchases.configure(withAPIKey: APIKeys.revenueCat)
        #if DEBUG
        Purchases.logLevel = .debug
        #else
        Purchases.logLevel = .info
        #endif
        Purchases.shared.attribution.setAttributes([
            "$telemetryDeckUserId": TelemetryManager.shared.hashedDefaultUser,
            "$telemetryDeckAppId": APIKeys.telemetryDeckAppID
        ])
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                if let beansVM {
                    CoffeeTrackerMain()
                        .environment(\.managedObjectContext, beansVM.context)
                        .environmentObject(beansVM)
                        .environment(reviewPrompt)
                        .task {
                            Analytics.appOpened(libraryCount: beansVM.beans.count).send()
                        }
                }
                if showingLaunchAnimation {
                    LaunchAnimationView(isReady: beansVM != nil) {
                        showingLaunchAnimation = false
                    }
                }
            }
            .task {
                guard beansVM == nil else { return }
                let persistenceController = await Task.detached { PersistenceController.shared }.value
                beansVM = BeansCollectionViewOO(context: persistenceController.container.viewContext)
            }
        }
    }
}
