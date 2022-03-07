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
            }
            .padding(.horizontal)
            BeanDetailView(bean: bean)
        }.padding(.top)
            .background(Color.UI.bone)
            .cornerRadius(10)
            .padding(.vertical, 5)
    }
}

struct BeanRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BeanRowView(bean: testRoast)
        }
    }
}
