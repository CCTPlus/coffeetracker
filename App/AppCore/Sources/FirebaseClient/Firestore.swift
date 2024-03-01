//
//  Firestore.swift
//
//
//  Created by Jay on 3/1/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

extension FirebaseClient {
  public func updateUserLastSignedIn() async throws {
    guard let userID else {
      throw FirebaseClientError.noUserSignedIn
    }
    let docRef = db.collection(Collection.users.rawValue).document(userID)
    try await docRef.setData(["dateLastSignedIn": FieldValue.serverTimestamp()])
  }
}
