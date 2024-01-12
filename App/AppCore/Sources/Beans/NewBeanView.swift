//
//  NewBeanView.swift
//
//
//  Created by Jay on 1/12/24.
//

import Models
import SwiftUI

struct NewBeanView: View {
  var save: () -> Void
  var cancel: () -> Void

  @State private var newBean = Bean(
    name: "",
    website: "",
    roastStyle: .medium
  )

  var body: some View {
    Form {
      TextField("Name", text: $newBean.name)
      TextField("Website", text: $newBean.website)
      Picker("Roast Style", selection: $newBean.roastStyle) {
        ForEach(RoastStyle.allCases) { roastStyle in
          Text(roastStyle.long)
            .tag(roastStyle)
        }
      }
    }
    .navigationTitle("New Bean")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem {
        Button("Save") {
          save()
        }
      }
      ToolbarItem(placement: .topBarLeading) {
        Button("Cancel") {
          cancel()
        }
        .tint(.red)
      }
    }
  }
}

#Preview {
  NavigationStack {
    NewBeanView(save: { print("save") }, cancel: { print("cancel") })
  }
}
