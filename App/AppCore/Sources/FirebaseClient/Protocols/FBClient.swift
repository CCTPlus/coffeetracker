//
//  FBClient.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation
import Models

public protocol FBClient {
  func signInAnonymously() async throws
  func updateUserLastSignedIn() async throws
  func createBeanInUser(_ bean: Bean) async throws
}
