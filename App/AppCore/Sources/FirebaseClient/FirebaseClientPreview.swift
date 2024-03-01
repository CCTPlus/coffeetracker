//
//  FirebaseClientPreview.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation
import Models

@Observable
public class FirebaseClientPreview: FBClient {
  public func signInAnonymously() async throws {
    print("success")
  }

  public func updateUserLastSignedIn() async throws {
    print("success")
  }

  public func createBeanInUser(_ bean: Models.Bean) async throws {
    print("success")
  }
}
