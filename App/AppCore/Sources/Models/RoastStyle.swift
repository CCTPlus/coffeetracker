//
//  RoastStyle.swift
//
//
//  Created by Jay on 3/8/24.
//

import Foundation

public enum RoastStyle: Int, Identifiable, CaseIterable, Codable {
  public var id: Int {
    self.rawValue
  }

  case light, medium, dark

  public var long: String {
    switch self {
      case .light:
        "Light roast"
      case .medium:
        "Medium roast"
      case .dark:
        "Dark roast"
    }
  }

  public var abbreviated: String {
    switch self {
      case .light:
        "light"
      case .medium:
        "medium"
      case .dark:
        "dark"
    }
  }

  public var fbKey: String {
    switch self {
      case .light:
        "light"
      case .medium:
        "medium"
      case .dark:
        "dark"
    }
  }
}
