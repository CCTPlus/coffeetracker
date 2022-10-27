//
//  Constants.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/18/22.
//

import Foundation
import CoreGraphics

enum APIKeys {
    static let revenueCat = ProcessInfo.processInfo.environment["RevenueCatKey"] ?? ""
    static let gitHubKey = ProcessInfo.processInfo.environment["GitHubAPI"] ?? ""
    static let posthogKey = ProcessInfo.processInfo.environment["PostHogKey"] ?? ""
}

enum Design {
    static let base: CGFloat = 10
}

enum ASKeys {
    static let timesLaunched = "timesLaunched"
}

enum Urls {
    static let review = "https://apps.apple.com/us/app/coffee/id1611166034?action=write-review"
}
