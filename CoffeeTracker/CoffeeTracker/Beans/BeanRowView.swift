//
//  BeanRow.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import Foundation
import SwiftUI

struct BeanRowView: View {
    var bean: BeanModel

    var body: some View {
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
        }.padding()
            .background(Material.ultraThick)
            .cornerRadius(10)
            .padding(.vertical, 5)
    }
}

struct BeanRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BeanRowView(bean: testRoast)
        }
    }
}
