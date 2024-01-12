//
//  BeansListView.swift
//
//
//  Created by Jay on 1/12/24.
//

import Models
import SwiftUI

public struct BeansListView: View {
  let columns = [
    GridItem(.flexible(), spacing: 20),
    GridItem(.flexible(), spacing: 20),
  ]

  public init() {}

  public var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(0..<3) { _ in
          BeanCard(bean: Bean.mock)
            .shadow(radius: 4)
            .frame(height: 200)
        }
        // TODO: Add a new bean button
        HStack(alignment: .center) {
          Button {
            print("Add new bean")
          } label: {
            Image(systemName: "plus")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 50)
          }
          .frame(maxWidth: .infinity)
          .frame(height: 100)
          .padding(.vertical)
          .background(.thinMaterial)
          .clipShape(
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 20), style: .continuous)
          )
        }
        .shadow(radius: 4)
      }
    }
    .contentMargins(20.0)
  }
}

#Preview {
  BeansListView()
}
