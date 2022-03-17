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
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 100, height: 100, alignment: .center)
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
            }
            .foregroundColor(colorScheme == .dark ? .black : .primary)
            .padding(.leading, 10)
            .padding(.trailing)
            if showingDetails {
                BeanDetailView(bean: bean)
                    .foregroundColor(colorScheme == .dark ? .black : .primary)
            }

        }.padding(.top, 0)
            .padding(.bottom, 0)
            .background(colorScheme == .dark ? .primary : .secondary)
            .background(.thinMaterial)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.tertiary, lineWidth: 0.5)
            )
            .shadow(radius: 2)
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
    }
}
