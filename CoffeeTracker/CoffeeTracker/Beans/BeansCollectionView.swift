//
//  BeansCollectionView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeansCollectionView: View {
    var body: some View {
        NavigationView {
            List(allRoasts) { bean in
                NavigationLink {
                    BeanDetailView(bean: bean)
                } label: {
                    BeanRowView(bean: bean)
                }
            }.navigationTitle(Text("Beans"))
        }
    }
}

struct BeansCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        BeansCollectionView()
    }
}
