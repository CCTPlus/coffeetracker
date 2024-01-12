//
//  Bean.swift
//
//
//  Created by Jay on 1/12/24.
//

import Foundation

public enum RoastStyle: Int, Identifiable, CaseIterable {
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
}

public struct Bean: Equatable {
  public let id: UUID

  public var name: String
  public var website: String
  public var roastStyle: RoastStyle

  public init(id: UUID = UUID(), name: String, website: String, roastStyle: RoastStyle) {
    self.id = id
    self.name = name
    self.website = website
    self.roastStyle = roastStyle
  }
}

extension Bean {
  public static let mock = Bean(
    name: "Holler Mountain",
    website: "https://www.stumptowncoffee.com/products/holler-mountain",
    roastStyle: .medium
  )
}
