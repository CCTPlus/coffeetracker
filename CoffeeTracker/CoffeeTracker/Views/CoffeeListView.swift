//
//  BeansCollectionView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct CoffeeListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var beansOO: BeansCollectionViewOO

    @State private var search: String = ""

    @State private var beanTypeFilter = "all"
    let beanTypes = ["all", "pods", "beans", "grounds"]

    var body: some View {
            ScrollView {
                if beanTypeFilter == "all" {
                    ForEach(beansOO.beans, id: \.self) { bean in
                        BeanRowView(oo: BeanRowViewOO(bean: bean))
                            .padding(.vertical, Design.base/2)
                            .padding(.horizontal)
                    }
                } else {
                    ForEach(beansOO.beans.filter { $0.beanType == beanTypeFilter }, id: \.self) { bean in
                        BeanRowView(oo: BeanRowViewOO(bean: bean))
                            .padding(.vertical, Design.base/2)
                            .padding(.horizontal)
                    }
                }
            } .safeAreaInset(edge: .top) {
                VStack(alignment: .center, spacing: 8) {
                    HStack {
                        Text("Coffee")
                            .font(.largeTitle.weight(.bold))
                        Spacer()
                    }
                    Picker("Bean Type", selection: $beanTypeFilter) {
                        ForEach(beanTypes, id: \.self) { type in
                            Text(type.capitalized)
                        }
                    }.pickerStyle(.segmented)
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            .navigationBarHidden(true)
    }
}

struct BeansCollectionView_Previews: PreviewProvider {

    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                CoffeeListView()
                    .environmentObject(BeansCollectionViewOO(context: context))
            }
        }
    }
}
