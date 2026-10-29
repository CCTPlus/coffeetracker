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
import StoreKit
import TelemetryDeck

extension UIApplication {
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}

@main
struct CoffeeTrackerApp: App {
    @AppStorage(ASKeys.timesLaunched) var timesLaunched = 0

    @State private var beansVM: BeansCollectionViewOO?

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
                        .task {
                            Analytics.appOpened(libraryCount: beansVM.beans.count).send()
                            timesLaunched += 1
                            if timesLaunched > 5 {
                                guard let scene = UIApplication.shared.foregroundActiveScene else { return }
                                SKStoreReviewController.requestReview(in: scene)
                            }
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
