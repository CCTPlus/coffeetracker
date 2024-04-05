//
//  FirebaseClientPreview.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation
import Models
import OSLog
import Utilities

@Observable
public class FirebaseClientPreview: FBClient {
  public var roasters = [Roaster.mock]
  public var beans = [Bean.mock]

  public func signInAnonymously() async throws {
    Logger.fbClient.debug("Preview login was successful")
  }

  public func updateUserLastSignedIn() async throws {
    Logger.fbClient.debug("Preview updateUserLastSignedIn was successful")
  }

  public func createBeanInUser(_ bean: Models.Bean) async throws {
    Logger.fbClient.debug("Preview createBeanInUser was successful")
  }

  public func createRoasterInUser(_ roaster: Models.Roaster) async throws {
    Logger.fbClient.debug("Writing a roaster was successful")
  }
}
