//
//  NewBeanView.swift
//
//
//  Created by Jay on 1/12/24.
//

import Models
import Roasters
import SwiftUI

struct NewBeanView: View {
  @Environment(\.dismiss) var dismiss

  var save: (Bean) -> Void

  @State private var roasters: [Roaster] = [.mock]
  @State private var selectedRoaster = -1
  @State private var showNewRoaster = false

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

      Section {
        Picker("Roaster", selection: $selectedRoaster) {
          Text("Select roaster")
            .tag(-1)
          ForEach(Array(roasters.enumerated()), id: \.offset) { offset, roaster in
            Text(roaster.name)
              .tag(offset)
          }
          Text("New roaster")
            .tag(roasters.count)
        }
        .onChange(of: selectedRoaster) { oldValue, newValue in
          if newValue == roasters.count {
            showNewRoaster = true
          }
        }
        .sheet(
          isPresented: $showNewRoaster,
          onDismiss: {
            selectedRoaster = -1
          }
        ) {
          NavigationStack {
            NewRoasterView { roaster in
              roasters.append(roaster)
              showNewRoaster = false
            }
          }
          .presentationDetents([.medium, .large])
        }
      }
    }
    .navigationTitle("New Bean")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem {
        Button("Save") {
          save(newBean)
        }
      }
      ToolbarItem(placement: .topBarLeading) {
        Button("Cancel") {
          dismiss()
        }
        .tint(.red)
      }
    }
  }
}

#Preview {
  NavigationStack {
    NewBeanView(save: { _ in print("save") })
  }
}
