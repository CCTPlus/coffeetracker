//
//  BeansCollectionView.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 2/21/22.
//

import SwiftUI

struct CoffeeListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var beansOO: BeansCollectionViewOO

    @State private var beanTypeFilter = "all"
    let beanTypes = ["all", "pods", "beans", "grounds"]

    var filteredBeans: [BeanModel] {
        if beanTypeFilter == "all" {
            return beansOO.beans
        }
        return beansOO.beans.filter { $0.beanType == beanTypeFilter }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Picker("Bean Type", selection: $beanTypeFilter) {
                    ForEach(beanTypes, id: \.self) { type in
                        Text(type.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, Design.base)

                ForEach(filteredBeans, id: \.self) { bean in
                    BeanRowView(oo: BeanRowViewOO(bean: bean))
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.canvas.ignoresSafeArea())
        .navigationTitle("Coffee")
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    NavigationStack {
        CoffeeListView()
            .environmentObject(BeansCollectionViewOO(context: context))
    }
}
