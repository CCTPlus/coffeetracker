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

public struct Bean: Equatable, Identifiable {
  public let id: UUID

  public var name: String
  public var website: String
  public var roastStyle: RoastStyle

  public var roaster: Roaster?

  public var url: URL? {
    var isValidURL: Bool {
      let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
      if let match = detector.firstMatch(
        in: website,
        options: [],
        range: NSRange(location: 0, length: website.utf16.count)
      ) {
        // it is a link, if the match covers the whole string
        return match.range.length == website.utf16.count
      } else {
        return false
      }
    }
    if isValidURL {
      let url = URL(string: website)
      if var components = URLComponents(url: url!, resolvingAgainstBaseURL: false) {
        if components.scheme == nil {
          components.scheme = "http"
        }
        return components.url
      } else {
        return url
      }
    }
    return nil
  }

  public init(
    id: UUID = UUID(),
    name: String,
    website: String,
    roastStyle: RoastStyle,
    roaster: Roaster? = nil
  ) {
    self.id = id
    self.name = name
    self.website = website
    self.roastStyle = roastStyle
    self.roaster = roaster
  }
}

extension Bean {
  public static let mock = Bean(
    name: "Holler Mountain",
    website: "https://www.stumptowncoffee.com/products/holler-mountain",
    roastStyle: .medium,
    roaster: .mock
  )
}
