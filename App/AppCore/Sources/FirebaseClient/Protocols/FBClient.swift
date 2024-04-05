//
//  FBClient.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation
import Models

public protocol FBClient {
  var beans: [Bean] { get set }
  var roasters: [Roaster] { get set }

  func signInAnonymously() async throws
  func updateUserLastSignedIn() async throws
  func createBeanInUser(_ bean: Bean) async throws
  func createRoasterInUser(_ roaster: Roaster) async throws
}
