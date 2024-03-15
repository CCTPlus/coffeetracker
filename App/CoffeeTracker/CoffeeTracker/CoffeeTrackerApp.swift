//
//  CoffeeTrackerApp.swift
//  CoffeeTracker
//
//  Created by Jay on 1/12/24.
//
//  Supporters:
//  @mikaelacaron on Mar 8 2024
//

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

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
