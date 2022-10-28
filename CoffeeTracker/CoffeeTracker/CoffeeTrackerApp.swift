//
//  CoffeeTrackerApp.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

/*
 Supporters:
 MikaelaCaron
 */

import SwiftUI
import RevenueCat
import StoreKit
import PostHog

extension UIApplication {
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}

@main
struct CoffeeTrackerApp: App {
    @AppStorage(ASKeys.timesLaunched) var timesLaunched = 0

    let persistenceController = PersistenceController.shared

    @StateObject var beansVM = BeansCollectionViewOO(context: PersistenceController.shared.container.viewContext)
    @StateObject var navRouter = NavigationRouter()

    let postHog: PHGPostHog

    init() {
        Purchases.configure(withAPIKey: APIKeys.revenueCat)
        #if DEBUG
        Purchases.logLevel = .debug
        #else
        Purchases.logLevel = .info
        #endif

        let configuration = PHGPostHogConfiguration(apiKey: APIKeys.posthogKey)
        configuration.captureInAppPurchases = true
        configuration.recordScreenViews = false
        configuration.captureApplicationLifecycleEvents = true
        PHGPostHog.setup(with: configuration)

        postHog = PHGPostHog.shared()!
        postHog.identify(Purchases.shared.appUserID)

    }

    var body: some Scene {
        WindowGroup {
            CoffeeTrackerMain(navRouter: navRouter).tint(.accentColor)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(beansVM)
                .task {
                    timesLaunched += 1
                    if timesLaunched > 5 {
                        guard let scene = UIApplication.shared.foregroundActiveScene else { return }
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
        }
    }
}
