//
//  BeanCard.swift
//
//
//  Created by Jay on 1/12/24.
//

import Models
import SwiftUI

struct BeanCard: View {
  var bean: Bean
  var body: some View {
    VStack {
      Spacer()
      HStack {
        label
        Spacer()
      }
      .background(.thinMaterial)
    }
    .background(image)
  }

  @ViewBuilder
  var image: some View {
    Image(systemName: "photo.fill")
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
  @ViewBuilder
  var label: some View {
    VStack(alignment: .leading) {
      Text(bean.name)
        .font(.headline)
      Text(bean.roastStyle.abbreviated.capitalized(with: .current))
        .font(.subheadline)
    }
    .padding(.vertical, 8)
    .padding(.leading)
    .padding(.trailing, 4)
  }
}

#Preview {
  HStack(spacing: 20) {
    BeanCard(bean: .mock)
      .frame(width: 150, height: 200)

    BeanCard(bean: Bean(name: "Test", website: "", roastStyle: .light))
      .frame(width: 150, height: 200)
  }
}
