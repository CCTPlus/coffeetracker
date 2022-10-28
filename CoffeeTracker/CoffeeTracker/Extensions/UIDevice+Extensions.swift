//
//  UIDevice+Extensions.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 10/28/22.
//

import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
