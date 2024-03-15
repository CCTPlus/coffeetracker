//
//  NewBeanView.swift
//
//
//  Created by Jay on 1/12/24.
//

import FirebaseClient
import Models
import OSLog
import Roasters
import SwiftUI
import Utilities

struct NewBeanView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(FirebaseClient.self) var fb

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
          } else if newValue != -1 {
            newBean.roaster = roasters[newValue]
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
          Task {
            await save()
          }
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

  func save() async {
    newBean.fbRoastKey = newBean.roastStyle.fbKey
    do {
      try await fb.client.createBeanInUser(newBean)
      dismiss()
    } catch {
      Logger.fbClient.error("\(#function) \(error)")
    }
  }
}

#Preview {
  NavigationStack {
    NewBeanView()
  }
  .environment(FirebaseClient(isLive: false))
}
