//
//  BeansCollectionView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeansCollectionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var beansOO: BeansCollectionViewOO
    @State private var search: String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        Text("Beans")
                            .font(.largeTitle)
                        Spacer()
                    }.padding(.top, 20)
                }
                ScrollView {
                    ForEach(beansOO.beans, id: \.self) { bean in
                        NavigationLink {
                            BeanDetailView(bean: bean)
                        } label: {
                            BeanRowView(bean: bean)
                        }
                    }.tint(.primary)
                }
            }.navigationBarTitle("Beans")
                .navigationBarHidden(true)
        }.padding(.horizontal)
    }
}

struct BeansCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        BeansCollectionView()
    }
}
