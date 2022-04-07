//
//  BeanRow.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import Foundation
import SwiftUI

struct BeanRowView: View {
    @Environment(\.colorScheme) private var colorScheme

    @StateObject var viewModel: BeanRowViewModel

    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                withAnimation {
                    viewModel.toggleDetails()
                }
            }
    }

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: Design.base*2) {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(Design.base)
                    .frame(maxWidth: Design.base*10)
                VStack(alignment: .leading, spacing: Design.base/2) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(viewModel.name)
                                .font(.headline)
                            Text(viewModel.roaster)
                                .font(.subheadline)
                                .padding(.bottom, Design.base)
                        }
                        Spacer()
                        if viewModel.buyAgain {
                            Image(systemName: SFSymbols.thumbsup)
                                .opacity(0.60)
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(viewModel.style)
                            .font(.footnote)
                        Spacer()
                        viewModel.coffeeTypeIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                            .opacity(0.5)
                    }
                }
            }.padding(.horizontal, Design.base).padding(.top, Design.base)
                .padding(.bottom, viewModel.bottomPadding)

            if viewModel.showDetails {
                BeanDetailView(navRouter: NavigationRouter(), bean: viewModel.bean)
            }

        }.frame(maxWidth: .infinity)
            .row(padding: false)
            .gesture(tap)
    }
}

struct BeanRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                BeanRowView(viewModel: BeanRowViewModel(bean: testRoast))
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
                BeanRowView(viewModel: BeanRowViewModel(bean: testRoast))
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
            }
        }
        .preferredColorScheme(.dark)
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                BeanRowView(viewModel: BeanRowViewModel(bean: testRoast))
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
                BeanRowView(viewModel: BeanRowViewModel(bean: testRoast))
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
            }
        }
        .preferredColorScheme(.light)
    }
}
