//
//  CoffeeTrackerApp.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

/**
 Supporters:
 MikaelaCaron
 */

import SwiftUI
import RevenueCat

@main
struct CoffeeTrackerApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject var beansVM = BeansCollectionViewOO(context: PersistenceController.shared.container.viewContext)
    @StateObject var navRouter = NavigationRouter()

    init() {
        Purchases.configure(withAPIKey: APIKeys.revenueCat)
        Purchases.logLevel = .debug
    }

    var body: some Scene {
        WindowGroup {
            CoffeeTrackerMain(navRouter: navRouter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(beansVM)
        }
    }
}
