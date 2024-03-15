//
//  Auth.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation
import OSLog

/// Auth related functions
extension FirebaseClientLive {

  public func signInAnonymously() async throws {
    let result = try await auth.signInAnonymously()
    self.user = result.user
    self.userID = user?.uid
    Logger.fbClient.debug("Sign in attempt \(self.user?.uid ?? "")")

    // INITIALIZE SNAPSHOTS
    setupBeansSnapshotListener()
  }
}
