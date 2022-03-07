//
//  BeanDetailView.swift
//
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeanDetailView: View {
    @State private var showEditView = false

    var bean: BeanModel
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Group {
                    HStack {
                        Text("Bought on")
                        Spacer()
                        Text(formatDate(bean.boughtOn))
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                    HStack {
                        Text("Roasted on")
                        Spacer()
                        Text(formatDate(bean.roastedOn))
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                    HStack {
                        Text(bean.notes)
                            .lineLimit(nil)
                        Spacer()
                    }
                }.padding(.all)

                HStack {
                    Button(action: {print("Share")}) {
                        Image(systemName: SFSymbols.share)
                    }
                    Spacer()
                    Button(action: {print("delete")}) {
                        Image(systemName: SFSymbols.trash)
                    }
                    Spacer()
                    Button(action: {showEditView.toggle()}) {
                        Image(systemName: SFSymbols.pencil)
                    }
                }.padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
            .sheet(isPresented: $showEditView) {
                showEditView = false
            } content: {
                NewBeansView(showForm: $showEditView, beans: bean, isEdit: true)
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
            BeanDetailView(bean: testRoast)
                .preferredColorScheme(.dark)
        }
    }
}
