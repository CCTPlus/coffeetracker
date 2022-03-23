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
            HStack(spacing: 20) {
                Image(uiImage: bean.image)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .frame(maxWidth: 100)
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(bean.name)
                                .font(.headline)
                            Text(bean.roaster)
                                .font(.subheadline)
                                .padding(.bottom, 10)
                        }
                        Spacer()
                        if bean.buyAgain {
                            Image(systemName: SFSymbols.thumbsup)
                                .opacity(0.60)
                        }
                    }
                    Text(bean.style)
                        .font(.footnote)
                }
            }.padding(.horizontal, 10).padding(.top, 10)
                .padding(.bottom, !showingDetails ? 10 : 0)
            if showingDetails {
                BeanDetailView(bean: bean)
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
                BeanRowView(bean: testRoast)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                BeanRowView(bean: testRoast)
                    .padding(.vertical, 5)
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
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                BeanRowView(bean: testRoast)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
            }
        }
        .preferredColorScheme(.light)
    }
}
