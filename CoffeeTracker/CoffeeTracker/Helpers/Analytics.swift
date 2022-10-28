//
//  Analytics.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 10/27/22.
//

import Foundation
import PostHog
import UIKit

class Analytics {

    private let postHog = PHGPostHog.shared()!

    static let shared = Analytics()

    private let userProps = ["$set": [["iOSVersion": AppInfo.iosversion],
                                      ["appBuild": AppInfo.appBuild],
                                      ["$device_model": AppInfo.device]]]

    func captureWhatsNewView() {
        if !UIDevice.current.isSimulator {
            postHog.capture("whatsNewSeen", properties: userProps)
        } else {
            print("CAPTURED")
        }
    }

    func captureFormOpen() {
        if !UIDevice.current.isSimulator {
            postHog.capture("coffeeFormViewOpened", properties: userProps)
        } else {
            print("CAPTURED")
        }
    }

    func captureCoffeeSaved() {
        if !UIDevice.current.isSimulator {
            postHog.capture("coffeeFormSaved", properties: userProps)
        } else {
            print("CAPTURED")
        }
    }

    func captureCoffeeBuyButton() {
        if !UIDevice.current.isSimulator {
            postHog.capture("buyACoffeeButtonPushed", properties: ["appBuild": AppInfo.appBuild])
        } else {
            print("CAPTURED")
        }
    }
}
