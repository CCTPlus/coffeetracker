//
//  Roaster.swift
//
//
//  Created by Jay on 1/26/24.
//

import Foundation

public struct Roaster: Identifiable, Equatable, Codable {
  public let id: UUID
  public var name: String
  public var website: String?

  public init(id: UUID = UUID(), name: String = "", website: String? = nil) {
    self.id = id
    self.name = name
    self.website = website
  }
}

extension Roaster {
  public static let mock = Roaster(
    id: UUID(),
    name: "Stumptown Coffee",
    website: "https://stumptown.com"
  )
}
