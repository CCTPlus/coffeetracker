//
//  BeanDetailView.swift
//
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeanDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) private var colorScheme

    @StateObject var navRouter: NavigationRouter
    @StateObject var beanOO: NewBeanOO
    @State private var showEditView = false

    var body: some View {
        VStack(alignment: .leading) {

            Group {
                HStack {
                    Text("Bought on")
                    Spacer()
                    Text(beanOO.coffee.boughtOn.formatted(
                        .iso8601
                            .month()
                            .day()
                            .year()
                            .dateSeparator(.dash))
                    )
                }
                HStack {
                    Text("Roasted on")
                    Spacer()
                    Text(beanOO.coffee.roastedOn.formatted(
                        .iso8601
                            .month()
                            .day()
                            .year()
                            .dateSeparator(.dash))
                    )
                }
                if beanOO.coffee.notes.count > 0 {
                    VStack(alignment: .leading) {
                        Text("Notes")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, Design.base/4)
                        Text(beanOO.coffee.notes)
                            .lineLimit(nil)
                    }
                }
            }.padding(.all)

            HStack {
                /* Commented out for now Not ready to add share and delete
                 Button(action: {print("Share")}) {
                 Image(systemName: SFSymbols.share)
                 }
                 Spacer()
                 */
                Button { beanOO.coffee.deleteBean(context: viewContext) } label: {
                    Image(systemName: SFSymbols.trash)
                }
                Spacer()
                Button { showEditView.toggle() } label: {
                    Image(systemName: SFSymbols.pencil)
                }.foregroundColor(colorScheme == .dark ? .white : .accentColor)
            }.padding()
                .background(.thickMaterial)
                .cornerRadius(Design.base,
                              corners: [.bottomLeft, .bottomRight])
                .sheet(isPresented: $showEditView) {
                    showEditView = false
                } content: {
                    NewBeansView(navRouter: navRouter, beans: beanOO.coffee, isEdit: true)
                        .environmentObject(beanOO)
                }
        }
    }
}

struct BeanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BeanDetailView(navRouter: NavigationRouter(), beanOO: NewBeanOO(bean: testRoast))
        }
    }
}
