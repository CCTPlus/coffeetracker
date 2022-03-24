//
//  BeansCollectionView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeansCollectionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var beansOO: BeansCollectionViewOO

    @State private var search: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                HStack {
                    Spacer()
                        .frame(height: 100)
                }
                ForEach(beansOO.beans, id: \.self) { bean in
                    BeanRowView(bean: bean)
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                }
            }
            Group {
                GeometryReader { geometry in
                    HStack(alignment: .bottom) {
                        Text("Beans")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 10)
                            .padding(.leading)
                        Spacer()
                    }
                    .frame(height: geometry.safeAreaInsets.top+80)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10, corners: .bottomLeft)
                    .cornerRadius(10, corners: .bottomRight)
                    .edgesIgnoringSafeArea(.top)
                }
            }.shadow(radius: 20)
        }
    }
}

struct BeansCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            BeansCollectionView()
        }.preferredColorScheme(.dark)
    }
}
