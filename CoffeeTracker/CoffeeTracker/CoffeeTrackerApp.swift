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

@main
struct CoffeeTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoffeeTrackerMain()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
