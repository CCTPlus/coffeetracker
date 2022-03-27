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
    @State private var showEditView = false

    var bean: BeanModel

    var body: some View {
        VStack(alignment: .leading) {

            Group {
                HStack {
                    Text("Bought on")
                    Spacer()
                    Text(bean.boughtOn.formatted(
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
                    Text(bean.roastedOn.formatted(
                        .iso8601
                            .month()
                            .day()
                            .year()
                            .dateSeparator(.dash))
                    )
                }
                if bean.notes.count > 0 {
                    HStack {
                        Text(bean.notes)
                            .lineLimit(nil)
                        Spacer()
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
                Button(action: { bean.deleteBean(context: viewContext) }) {
                    Image(systemName: SFSymbols.trash)
                }
                Spacer()
                Button(action: {showEditView.toggle()}) {
                    Image(systemName: SFSymbols.pencil)
                }.foregroundColor(colorScheme == .dark ? .white : .accentColor)
            }.padding()
                .background(.thickMaterial)
                .cornerRadius(Design.base,
                              corners: [.bottomLeft, .bottomRight])
                .sheet(isPresented: $showEditView) {
                    showEditView = false
                } content: {
                    NewBeansView(navRouter: navRouter, beans: bean, isEdit: true)
                }
        }
    }
}

struct BeanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BeanDetailView(navRouter: NavigationRouter(), bean: testRoast)
        }
    }
}
