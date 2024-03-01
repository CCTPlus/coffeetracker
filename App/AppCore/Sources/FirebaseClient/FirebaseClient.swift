//
//  FirebaseClient.swift
//
//
//  Created by Jay on 3/1/24.
//

import FirebaseAuth
import Foundation
import OSLog
import Utilities

@Observable
public class FirebaseClient {
  public var userID: String?

  private var auth: Auth
  private var user: User?

  public init() {
    self.userID = nil
    self.auth = Auth.auth()
    self.user = nil
  }

  public func signInAnonymously() async throws {
    let result = try await auth.signInAnonymously()
    self.user = result.user
    self.userID = user?.uid

    Logger.fbClient.debug("Sign in attempt \(self.user?.uid ?? "")")
  }
