//
//  BeanDetailView.swift
//
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeanDetailView: View {
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
                    Text(formatDate(bean.boughtOn))
                }
                HStack {
                    Text("Roasted on")
                    Spacer()
                    Text(formatDate(bean.roastedOn))
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
                Button(action: {print("delete")}) {
                    Image(systemName: SFSymbols.trash)
                } */
                Spacer()
                Button(action: {showEditView.toggle()}) {
                    Image(systemName: SFSymbols.pencil)
                }.foregroundColor(colorScheme == .dark ? .white : .accentColor)
            }.padding()
                .background(.thickMaterial)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .sheet(isPresented: $showEditView) {
                    showEditView = false
                } content: {
                    NewBeansView(navRouter: navRouter, beans: bean, isEdit: true)
                }
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, YYYY"

        return formatter.string(from: date)
    }
}

struct BeanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BeanDetailView(navRouter: NavigationRouter(), bean: testRoast)
        }
    }
}
