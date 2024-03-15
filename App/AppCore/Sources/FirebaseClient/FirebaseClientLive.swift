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
import Models
import OSLog
import Utilities

@Observable
public class FirebaseClientLive: FBClient {
  // MARK: Authentication Variables
  public var userID: String?
  var auth: Auth
  var user: User?

  // MARK: Collection Variables
  var db: Firestore

  public var beans: [Bean] = []

  public init() {
    self.userID = nil
    self.auth = Auth.auth()
    self.user = nil
    self.db = Firestore.firestore()
  }
}
