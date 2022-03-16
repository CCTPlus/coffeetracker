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
        VStack(alignment: .leading) {
            Text("Beans")
                .font(.largeTitle)
                .padding()
            ScrollView {
                HStack {
                    Spacer()
                }
                ForEach(beansOO.beans, id: \.self) { bean in
                    BeanRowView(bean: bean)
                        .padding()
                }
            }
        }
    }
}

struct BeansCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        BeansCollectionView()
    }
}
