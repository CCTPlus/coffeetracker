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
    @StateObject var beansVM = BeansCollectionViewOO(context: PersistenceController.shared.container.viewContext)

    var body: some Scene {
        WindowGroup {
            CoffeeTrackerMain()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(beansVM)
        }
    }
}
