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
  public var beanIDs: [String]

  /// Used for tag purposes like selecting from a picker
  public var tagValue: Int {
    id.hashValue
  }

  public init(
    id: UUID = UUID(),
    name: String = "",
    website: String? = nil,
    dateAdded: Date = Date(),
    dateModified: Date = Date(),
    beanIDs: [String] = []
  ) {
    self.id = id
    self.name = name
    self.website = website
    self.dateAdded = dateAdded
    self.dateModified = dateModified
    self.beanIDs = beanIDs
  }
}
