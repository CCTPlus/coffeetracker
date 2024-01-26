//
//  Roaster.swift
//
//
//  Created by Jay on 1/26/24.
//

import Foundation

public struct Roaster: Identifiable {

  public let id: UUID
  public var name: String
  public var website: String?

  public var beans: [Bean] = []

  public init(id: UUID = UUID(), name: String = "", website: String? = nil, beans: [Bean] = []) {
    self.id = id
    self.name = name
    self.website = website
    self.beans = beans
  }
}

extension Roaster {
  public static let mock = Roaster(
    id: UUID(),
    name: "Stumptown Coffee",
    website: "https://stumptown.com",
    beans: [.mock]
  )
}
