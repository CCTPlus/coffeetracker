//
//  AppView.swift
//
//
//  Created by Jay on 1/12/24.
//

import FirebaseClient
import OSLog
import SwiftUI
import Utilities

public struct AppView: View {
  @State private var fbClient = FirebaseClient()
  public init() {}
  public var body: some View {
    TabView {
      ForEach(Tab.allCases) { tab in
        tab.view
          .tabItem {
            Label(
              title: { Text(tab.label) },
              icon: { Image(systemName: tab.icon) }
            )
          }
      }
    }
    .task {
      do {
        try await fbClient.signInAnonymously()
        try await fbClient.updateUserLastSignedIn()
      } catch {
        Logger.fbClient.error("🚨: Could not sign in \(error)")
      }
    }
  }
}

#Preview {
  AppView()
}
