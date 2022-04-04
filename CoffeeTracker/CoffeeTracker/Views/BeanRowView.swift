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

    @State private var showingDetails = false

    var bean: BeanModel

    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                withAnimation {
                    showingDetails.toggle()
                }
            }
    }

    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: Design.base*2) {
                Image(uiImage: bean.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(Design.base)
                    .frame(maxWidth: Design.base*10)
                VStack(alignment: .leading, spacing: Design.base/2) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(bean.name)
                                .font(.headline)
                            Text(bean.roaster)
                                .font(.subheadline)
                                .padding(.bottom, Design.base)
                        }
                        Spacer()
                        if bean.buyAgain {
                            Image(systemName: SFSymbols.thumbsup)
                                .opacity(0.60)
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(bean.style)
                            .font(.footnote)
                        Spacer()
                        switch bean.beanType {
                        case "pods":
                            Image(systemName: SFSymbols.rectRoundedBottom)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.5)
                        case "grounds":
                            Image("CoffeeBag")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.5)
                        default:
                            Image("CoffeeBean")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.5)
                        }
                    }
                }
            }.padding(.horizontal, Design.base).padding(.top, Design.base)
                .padding(.bottom, !showingDetails ? Design.base : 0)
            if showingDetails {
                BeanDetailView(navRouter: NavigationRouter(), bean: bean)
            }

        }.frame(maxWidth: .infinity)
            .row(padding: false)
            .gesture(tap)
//            .animation(.default, value: showingDetails)
    }
}

struct BeanRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                BeanRowView(bean: mediumRoast)
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
                BeanRowView(bean: testRoast)
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
                BeanRowView(bean: testRoast)
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
                BeanRowView(bean: testRoast)
                    .padding(.vertical, Design.base/2)
                    .padding(.horizontal)
            }
        }
        .preferredColorScheme(.light)
    }
}
