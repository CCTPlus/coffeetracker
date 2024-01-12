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

  @State private var isNewBeanSheetPresented = false
  @State private var beans: [Bean] = [.mock]

  public var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 20) {
        ForEach(beans) { bean in
          BeanCard(bean: bean)
            .frame(minHeight: 150, maxHeight: 200)
            .clipShape(
              RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous)
            )
            .shadow(radius: 4)
        }
        newBeanButton
          .sheet(isPresented: $isNewBeanSheetPresented) {
            NavigationStack {
              NewBeanView { bean in
                beans.append(bean)
                isNewBeanSheetPresented.toggle()
              }
            }
            .presentationDetents([.medium])
          }
      }
    }
    .contentMargins(20.0)
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
}
