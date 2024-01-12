//
//  AppView.swift
//
//
//  Created by Jay on 1/12/24.
//

import SwiftUI

public struct AppView: View {
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
  }
}

#Preview {
  AppView()
}
