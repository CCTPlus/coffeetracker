//
//  Firestore.swift
//
//
//  Created by Jay on 3/1/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import Models
import OSLog
import Utilities

extension FirebaseClientLive {
  func userDoc() throws -> DocumentReference {
    guard let userID else {
      throw FirebaseClientError.noUserSignedIn
    }
    return db.collection(Collection.users.rawValue).document(userID)
  }

  public func updateUserLastSignedIn() async throws {
    let docRef = try userDoc()
    try await docRef.setData(["dateLastSignedIn": FieldValue.serverTimestamp()])
  }
}
