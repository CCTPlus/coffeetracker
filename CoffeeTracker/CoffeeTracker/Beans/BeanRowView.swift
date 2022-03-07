//
//  BeanRow.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import Foundation
import SwiftUI

struct BeanRowView: View {
    @State private var showingDetails = false

    var bean: BeanModel

    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                showingDetails.toggle()
            }
    }

    var body: some View {
        VStack{
            HStack(spacing: 20) {
                Image(systemName: SFSymbols.bag)
                    .font(.title)
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .top) {
                        VStack {
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
            }.gesture(tap)
            .padding(.horizontal)
            if showingDetails {
                BeanDetailView(bean: bean)
                    .opacity(showingDetails ? 1 : 0)
            }
        }.padding(.top, 10)
            .padding(.bottom, showingDetails ? 0 : 10)
            .background(Color.UI.bone)
            .cornerRadius(10)
            .padding(.vertical, 5)
            .animation(.default, value: showingDetails)
    }
}

struct BeanRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BeanRowView(bean: testRoast)
        }
    }
}
