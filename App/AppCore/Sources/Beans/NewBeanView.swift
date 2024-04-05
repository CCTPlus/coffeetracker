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

  /// Determines the selected roaster
  ///
  /// - Roaster selected = hash value of `Roaster.id`
  /// - New Roaster selected = 0
  /// - No roaster selected = -1
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
          ForEach(fb.client.roasters) { roaster in
            Text(roaster.name)
              .tag(roaster.tagValue)
          }
          Text("New roaster")
            .tag(0)
        }
        .onChange(of: selectedRoaster) { oldValue, newValue in
          switch newValue {
            case 0:
              showNewRoaster = true
            case -1:
              break
            default:
              newBean.roaster = fb.client.roasters.first(where: { $0.tagValue == newValue })
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
              Task {
                do {
                  try await fb.client.createRoasterInUser(roaster)
                  showNewRoaster = false
                } catch {
                  Logger.fbClient.error("🚨 Can't create a new roaster. \(error, privacy: .public)")
                }
              }
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
