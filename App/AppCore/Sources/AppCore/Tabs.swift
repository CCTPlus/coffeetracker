//
//  Tabs.swift
//
//
//  Created by Jay on 1/12/24.
//

import Foundation
import SwiftUI

enum Tab: Int, Identifiable, CaseIterable {
  var id: Int {
    self.rawValue
  }

  case coffee, settings

  /// Label for the tab
  var label: String {
    switch self {
      case .coffee:
        "Coffee"
      case .settings:
        "Settings"
    }
  }

  /// SF Symbol for tab icon
  var icon: String {
    switch self {
      case .coffee:
        "bag"
      case .settings:
        "gear"
    }
  }

  /// Root view of the selected tab
  @ViewBuilder
  var view: some View {
    switch self {
      case .coffee:
        Text(self.label)
      case .settings:
        Text(self.label)
    }
  }
}
