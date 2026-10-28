//
//  BeanRow.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 2/21/22.
//

import Foundation
import SwiftUI

struct BeanRowView: View {
    @StateObject var oo: BeanRowViewOO

    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                withAnimation {
                    oo.toggleDetails()
                }
            }
    }

    var body: some View {
        VStack(spacing: Design.base) {
            HStack(alignment: .center, spacing: Design.base*1.4) {
                thumbnail
                VStack(alignment: .leading, spacing: Design.base/5) {
                    Text(oo.name)
                        .font(.headline)
                    Text(oo.roaster)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    if !oo.metadata.isEmpty {
                        Text(oo.metadata)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.top, Design.base/5)
                    }
                }
                Spacer()
                if oo.buyAgain {
                    Image(systemName: SFSymbols.thumbsup)
                        .foregroundStyle(.secondary)
                        .accessibilityLabel("Would buy again")
                }
            }

            if oo.showDetails {
                BeanDetailView(beanOO: NewBeanOO(bean: oo.bean))
                    .padding(.leading, Design.thumbnail + Design.base*1.4)
            }
        }
        .padding(.vertical, Design.base*1.2)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .gesture(tap)
    }

    @ViewBuilder
    private var thumbnail: some View {
        let shape = RoundedRectangle(cornerRadius: Design.base*1.2, style: .continuous)
        if oo.hasPhoto {
            Image(uiImage: oo.image)
                .resizable()
                .scaledToFill()
                .frame(width: Design.thumbnail, height: Design.thumbnail)
                .clipShape(shape)
        } else {
            shape
                .fill(Color.placeholderTile)
                .frame(width: Design.thumbnail, height: Design.thumbnail)
                .overlay {
                    oo.coffeeTypeIcon
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .padding(Design.base*2.2)
                        .foregroundStyle(Color.placeholderIcon)
                }
                .accessibilityHidden(true)
        }
    }
}

#Preview("Dark") {
    ScrollView {
        BeanRowView(oo: BeanRowViewOO(bean: testRoast))
            .padding(.horizontal)
        BeanRowView(oo: BeanRowViewOO(bean: mediumRoast))
            .padding(.horizontal)
    }
    .background(Color.canvas)
    .preferredColorScheme(.dark)
}

#Preview("Light") {
    ScrollView {
        BeanRowView(oo: BeanRowViewOO(bean: testRoast))
            .padding(.horizontal)
        BeanRowView(oo: BeanRowViewOO(bean: mediumRoast))
            .padding(.horizontal)
    }
    .background(Color.canvas)
    .preferredColorScheme(.light)
}
