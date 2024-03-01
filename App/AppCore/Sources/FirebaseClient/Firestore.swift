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

extension FirebaseClientLive {
  public func updateUserLastSignedIn() async throws {
    guard let userID else {
      throw FirebaseClientError.noUserSignedIn
    }
    let docRef = db.collection(Collection.users.rawValue).document(userID)
    try await docRef.setData(["dateLastSignedIn": FieldValue.serverTimestamp()])
  }

  /// Adds a bean to the user's collection
  public func createBeanInUser(_ bean: Bean) async throws {
    guard let userID else {
      throw FirebaseClientError.noUserSignedIn
    }

    let beansCollectionRef = db.collection(Collection.users.rawValue).document(userID)
      .collection(Collection.beans.rawValue)

    try beansCollectionRef.document().setData(from: bean)
  }
}
