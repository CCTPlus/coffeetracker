//
//  Tabs.swift
//
//
//  Created by Jay on 1/12/24.
//

import Beans
import Foundation
import SwiftUI
import Beans

enum Tab: Int, Identifiable, CaseIterable {
    var id: Int {
        self.rawValue
    }

    case coffee, settings

  /// Root view of the selected tab
  @ViewBuilder
  var view: some View {
    switch self {
      case .coffee:
        BeansListView()
      case .settings:
        Text(self.label)
    }
}
