//
//  Bean.swift
//
//
//  Created by Jay on 1/12/24.
//

import Foundation

public struct Bean: Equatable, Identifiable, Codable {
  public let id: UUID

  public var name: String
  public var website: String
  public var roastStyle: RoastStyle

  /// Only used to write the roastkey to the fb doc
  public var fbRoastKey: String

  public var roaster: Roaster?
  public var dateAdded: Date
  public var dateModified: Date

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
    roaster: Roaster? = nil,
    dateAdded: Date = Date(),
    dateModified: Date = Date()
  ) {
    self.id = id
    self.name = name
    self.website = website
    self.roastStyle = roastStyle
    self.roaster = roaster
    self.fbRoastKey = roastStyle.fbKey
    self.dateAdded = dateAdded
    self.dateModified = dateModified
  }

  /// Properties of the data in Firestore
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case website
    // TODO: Think about renaming the key in firestore
    case roastStyle
    case fbRoastKey = "roast_style"
    case roaster
    case dateAdded
    case dateModified
  }
}
