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
                    Text(bean.name)
                        .font(.headline)
                    Text(bean.roaster)
                        .font(.subheadline)
                        .padding(.bottom, 10)
                    HStack {
                        Text(bean.style)
                            .font(.subheadline)
                        Spacer()
                        Group {
                            bean.buyAgain ? Image(systemName: SFSymbols.thumbsup) : Image(systemName: SFSymbols.thumbsdown)
                        }.foregroundColor(bean.buyAgain ? .green : .red)
                    }
                }
            }
            BeanDetailView(bean: bean)
        }.padding(.top)
            .background(Color.brown)
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
