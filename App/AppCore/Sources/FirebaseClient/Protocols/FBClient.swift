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
  // MARK: User associated
  func signInAnonymously() async throws
  func updateUserLastSignedIn() async throws
  // MARK: Bean functions
  func createBeanInUser(_ bean: Bean) async throws
  // MARK: Roaster functions
  func createRoasterInUser(_ roaster: Roaster) async throws
  func addBeanToRoaster(_ roaster: Roaster, bean: Bean) async throws
}
