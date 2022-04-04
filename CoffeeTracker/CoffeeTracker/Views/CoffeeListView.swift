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

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                HStack {
                    Spacer()
                        .frame(height: Design.base*10)
                }
                ForEach(beansOO.beans, id: \.self) { bean in
                    BeanRowView(bean: bean)
                        .padding(.vertical, Design.base/2)
                        .padding(.horizontal)
                }
                HStack {
                    Spacer()
                        .frame(height: Design.base*12)
                }
            }
            Group {
                GeometryReader { geometry in
                    HStack(alignment: .bottom) {
                        Text("Coffee")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, Design.base)
                            .padding(.leading)
                        Spacer()
                    }
                    .frame(height: geometry.safeAreaInsets.top+Design.base*8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(Design.base, corners: .bottomLeft)
                    .cornerRadius(Design.base, corners: .bottomRight)
                    .edgesIgnoringSafeArea(.top)
                }
            }.shadow(radius: Design.base*2)
        }
    }
}

struct BeansCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            CoffeeListView()
        }.preferredColorScheme(.dark)
    }
}
