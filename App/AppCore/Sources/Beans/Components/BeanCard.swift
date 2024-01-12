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
      label
    }
    .background(image)
    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 20), style: .continuous))
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
      Text(bean.roastStyle.abbreviated)
        .font(.subheadline)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .background(.thickMaterial)
  }
}

#Preview {
  BeanCard(bean: .mock)
    .frame(width: 200, height: 200)
}
