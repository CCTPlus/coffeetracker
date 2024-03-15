//
//  BeansListView.swift
//
//
//  Created by Jay on 1/12/24.
//

import FirebaseClient
import Models
import SwiftUI

public struct BeansListView: View {
  @Environment(FirebaseClient.self) var fb
  let columns = [
    GridItem(.flexible(), spacing: 20),
    GridItem(.flexible(), spacing: 20),
  ]

  public init() {}

  @State private var isNewBeanSheetPresented = false

  public var body: some View {
    NavigationStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 20) {
          existingBeans
          newBeanButton
            .sheet(isPresented: $isNewBeanSheetPresented) {
              NavigationStack {
                NewBeanView()
                  .environment(fb)
              }
              .presentationDetents([.medium])
            }
        }
      }
      .contentMargins(20.0)
      .navigationTitle("Coffee")
    }
  }

  @ViewBuilder
  var existingBeans: some View {
    ForEach(fb.client.beans) { bean in
      NavigationLink {
        BeansDetailView(bean: bean)
      } label: {
        BeanCard(bean: bean)
          .frame(minHeight: 150, maxHeight: 200)
          .clipShape(
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous)
          )
          .shadow(radius: 4)
      }
      .tint(.primary)
    }
  }

  @ViewBuilder
  var newBeanButton: some View {
    HStack(alignment: .center) {
      Button {
        isNewBeanSheetPresented.toggle()
      } label: {
        Image(systemName: "plus")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 50)
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
      .background(.thinMaterial)
      .clipShape(
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous)
      )
    }
    .shadow(radius: 4)
  }
}

#Preview {
  BeansListView()
    .environment(FirebaseClient(isLive: false))
}
