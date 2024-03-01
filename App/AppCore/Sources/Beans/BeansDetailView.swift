//
//  BeansDetailView.swift
//
//
//  Created by Jay on 1/19/24.
//

import Models
import SwiftUI

struct BeansDetailView: View {
  var bean: Bean

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        if let roaster = bean.roaster {
          // TODO: Link to a detail view of the roaster
          Text(roaster.name)
        }
        HStack {
          Text("Roast Style")
          Spacer()
          Text(bean.roastStyle.abbreviated)
        }
      }
      .padding(.bottom)
      VStack(alignment: .leading) {
        if let url = bean.url {
          Link(destination: url) {
            Label("Visit website", systemImage: "safari")
          }
        } else {
          HStack {
            Text("Website")
            Spacer()
            Text(bean.website)
              .textSelection(.enabled)
          }
        }
      }
    }
    .contentMargins(20)
    .navigationTitle(bean.name)
  }
}

#Preview {
  NavigationStack {
    BeansDetailView(bean: .mock)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Back") {
            print("Go back")
          }
        }
      }
  }
}
