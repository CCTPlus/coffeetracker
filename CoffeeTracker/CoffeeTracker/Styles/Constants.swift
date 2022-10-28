//
//  Constants.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/18/22.
//

import Foundation
import CoreGraphics
import UIKit

enum APIKeys {
    static let revenueCat = ProcessInfo.processInfo.environment["RevenueCatKey"] ?? ""
    static let gitHubKey = ProcessInfo.processInfo.environment["GitHubAPI"] ?? ""
    static let posthogKey = ProcessInfo.processInfo.environment["PostHogKey"] ?? ""
}

enum AppInfo {
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "2022"
    static let appBuild: String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    static let iosversion = UIDevice.current.systemVersion
    static let device = UIDevice.current.localizedModel
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
