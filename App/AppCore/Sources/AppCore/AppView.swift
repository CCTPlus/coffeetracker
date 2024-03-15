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
  @Environment(FirebaseClient.self) var fb

  public init() {}

  public var body: some View {
    TabView {
      ForEach(Tab.allCases) { tab in
        tab.view
          .environment(fb)
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
        try await fb.client.signInAnonymously()
        try await fb.client.updateUserLastSignedIn()
      } catch {
        Logger.fbClient.error("🚨: Could not sign in \(error)")
      }
    }
  }
}

#Preview {
  AppView()
    .environment(FirebaseClient(isLive: false))
}
