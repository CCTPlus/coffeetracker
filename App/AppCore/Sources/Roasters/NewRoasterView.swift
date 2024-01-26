//
//  NewRoasterView.swift
//
//
//  Created by Jay on 1/26/24.
//

import Models
import SwiftUI

public struct NewRoasterView: View {
  @Environment(\.dismiss) var dismiss
  @State private var newRoaster = Roaster()
  @State private var website = ""

  var save: (Roaster) -> Void

  public init(save: @escaping (Roaster) -> Void) {
    self.save = save
  }

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
    }
    .navigationTitle("New Roaster")
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          dismiss()
        } label: {
          Text("Cancel")
        }
        .tint(.red)
      }
      ToolbarItem {
        Button {
          save(newRoaster)
        } label: {
          Text("Save")
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    NewRoasterView(save: { _ in print("Run") })
  }
}
