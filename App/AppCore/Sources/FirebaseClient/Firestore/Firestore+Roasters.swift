import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import Models
import OSLog
import Utilities

// Deals with firestore actions to read/write roasters
extension FirebaseClientLive {
  public func createRoasterInUser(_ roaster: Roaster) async throws {
    let docRef = try userDoc()
    let roastersCollection = docRef.collection(Collection.roasters.rawValue)

    let newRoaster = roastersCollection.document()
    try newRoaster.setData(from: roaster)
    try await newRoaster.updateData(
      [
        "dateAdded": FieldValue.serverTimestamp(),
        "dateModified": FieldValue.serverTimestamp(),
      ]
    )
  }

  func setupUserRoastersSnapshotListener() {
    guard let docRef = try? userDoc() else {
      Logger.fbClient.error("\(FirebaseClientError.noUserSignedIn)")
      return
    }

    docRef
      .collection(Collection.roasters.rawValue)
      .order(by: "name")
      .addSnapshotListener { snapshot, error in
        Logger.fbClient.debug("The user's Roasters collection have changed")
        guard error == nil else {
          Logger.fbClient.error("🚨 \(#function, privacy: .public) \(error!)")
          return
        }

        guard let snapshot else {
          Logger.fbClient.error("🚨 No snapshot and no error... this is weird")
          return
        }
        Logger.fbClient.debug("\(snapshot.count)")

        let foundRoasters = snapshot.documents.compactMap { docSnap in
          try? docSnap.data(as: Roaster.self)
        }
        self.roasters = foundRoasters
      }
  }
}
