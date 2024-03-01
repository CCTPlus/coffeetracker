//
//  Logger.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation
import OSLog

enum LogCategory: String {
  case `default`
  case fbClient
}

extension Logger {
  private static let subsytem = "coffeeTracker"
  public static let `default` = Logger(subsystem: subsytem, category: LogCategory.default.rawValue)
  public static let fbClient = Logger(subsystem: subsytem, category: LogCategory.fbClient.rawValue)
}
