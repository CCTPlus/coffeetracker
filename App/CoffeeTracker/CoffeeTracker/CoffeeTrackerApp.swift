//
//  CoffeeTrackerApp.swift
//  CoffeeTracker
//
//  Created by Jay on 1/12/24.
//

import AppCore
import FirebaseClient
import FirebaseCore
import SwiftUI

// configure firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CoffeeTrackerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @State private var firebaseClient = FirebaseClient()

  var body: some Scene {
    WindowGroup {
      AppView()
        .environment(firebaseClient)
    }
  }
}
