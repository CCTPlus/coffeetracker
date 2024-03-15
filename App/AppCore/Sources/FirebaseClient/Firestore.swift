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
  private func userDoc() throws -> DocumentReference {
    guard let userID else {
      throw FirebaseClientError.noUserSignedIn
    }
    return db.collection(Collection.users.rawValue).document(userID)
  }

  public func updateUserLastSignedIn() async throws {
    let docRef = try userDoc()
    try await docRef.setData(["dateLastSignedIn": FieldValue.serverTimestamp()])
  }

  /// Adds a bean to the user's collection
  public func createBeanInUser(_ bean: Bean) async throws {
    let docRef = try userDoc()
    let beansCollectionRef = docRef.collection(Collection.beans.rawValue)

    let newBeanRef = beansCollectionRef.document()
    try newBeanRef.setData(from: bean)
    try await newBeanRef.updateData(
      [
        "dateAdded": FieldValue.serverTimestamp(),
        "dateModified": FieldValue.serverTimestamp(),
      ]
    )
  }

  func setupBeansSnapshotListener() {
    guard let docRef = try? userDoc() else {
      Logger.fbClient.error("\(FirebaseClientError.noUserSignedIn)")
      return
    }

    docRef
      .collection(Collection.beans.rawValue)
      .order(by: "name")
      .addSnapshotListener { snapshot, error in
        Logger.fbClient.debug("Beans collections have changed")
        guard error == nil else {
          Logger.fbClient.error("🚨 \(#function) \(error!)")
          return
        }

        guard let snapshot else {
          Logger.fbClient.error("🚨 No snapshot and no error... this is weird")
          return
        }
        Logger.fbClient.debug("\(snapshot.count)")

        let foundBeans = snapshot.documents.compactMap { docSnap in
          try? docSnap.data(as: Bean.self)
        }
        self.beans = foundBeans
      }
  }

  private func updateBeans() {

  }
}
