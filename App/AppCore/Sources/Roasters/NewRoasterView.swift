//
//  NewRoasterView.swift
//
//
//  Created by Jay on 1/26/24.
//

import Models
import SwiftUI

public struct NewRoasterView: View {
  @State private var newRoaster = Roaster()
  @State private var website = ""

  public init() {}

  public var body: some View {
    Form {
      TextField("Roaster Name", text: $newRoaster.name)
      TextField("Website", text: $website)
        .onChange(of: website) { _, newValue in
          if newValue.isEmpty == false {
            newRoaster.website = newValue
          } else {
            newRoaster.website = nil
          }
        }

      #if DEBUG
        Section {
          Text("Roaster's website: \(newRoaster.website ?? "no website input")")
        }
      #endif
    }
    .navigationTitle("New Roaster")
  }
}

#Preview {
  NewRoasterView()
}
