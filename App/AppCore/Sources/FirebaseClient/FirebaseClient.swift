//
//  FirebaseClient.swift
//
//
//  Created by Jay on 3/1/24.
//

import Foundation

@Observable
public class FirebaseClient {
  public var client: FBClient

  public init(isLive: Bool = true) {
    self.client = isLive ? FirebaseClientLive() : FirebaseClientPreview()
  }
}
