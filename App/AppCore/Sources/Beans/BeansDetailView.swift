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
    List {
      HStack {
        Text("Roast Style")
        Spacer()
        Text(bean.roastStyle.abbreviated)
      }
      Section {
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
    .navigationTitle(bean.name)
  }
}

#Preview {
  NavigationStack {
    BeansDetailView(bean: .mock)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Text("< Back")
            .tint(Color.accentColor)
        }
      }
  }
}
