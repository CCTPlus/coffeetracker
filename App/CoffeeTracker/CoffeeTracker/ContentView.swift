//
//  ContentView.swift
//  CoffeeTracker
//
//  Created by Jay on 1/12/24.
//

import AppCore
import FirebaseClient
import SwiftUI

struct ContentView: View {
  @State private var firebaseClient = FirebaseClient()
  var body: some View {
    AppView()
      .environment(firebaseClient)
  }
}

#Preview {
  ContentView()
}
