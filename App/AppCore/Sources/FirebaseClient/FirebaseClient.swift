//
//  FirebaseClient.swift
//
//
//  Created by Jay on 3/1/24.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import Foundation
import OSLog
import Utilities

@Observable
public class FirebaseClient {
  // MARK: Authentication Variables
  public var userID: String?
  var auth: Auth
  var user: User?

  // MARK: Collection Variables
  var db: Firestore

  public init() {
    self.userID = nil
    self.auth = Auth.auth()
    self.user = nil
    self.db = Firestore.firestore()
  }

  public func signInAnonymously() async throws {
    let result = try await auth.signInAnonymously()
    self.user = result.user
    self.userID = user?.uid
    Logger.fbClient.debug("Sign in attempt \(self.user?.uid ?? "")")
  }
}
