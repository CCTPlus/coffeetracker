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
  public var dateAdded: Date
  public var dateModified: Date

  /// Used for tag purposes like selecting from a picker
  public var tagValue: Int {
    id.hashValue
  }

  public init(
    id: UUID = UUID(),
    name: String = "",
    website: String? = nil,
    dateAdded: Date = Date(),
    dateModified: Date = Date()
  ) {
    self.id = id
    self.name = name
    self.website = website
    self.dateAdded = dateAdded
    self.dateModified = dateModified
  }
}

extension Roaster {
  public static let mock = Roaster(
    id: UUID(),
    name: "Stumptown Coffee",
    website: "https://stumptown.com"
  )
}
