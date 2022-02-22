//
//  BeanDetailView.swift
//
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct BeanDetailView: View {
    var bean: BeanModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: SFSymbols.bag)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    Text(bean.name)
                    Text(bean.roaster)
                        .font(.subheadline)
                }
                Spacer()
            }.font(.largeTitle)
                .padding(.bottom, 25)

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
                }.padding(.vertical)

                HStack {
                    Text("Buy again?")
                    Spacer()
                    HStack {
                        Text(bean.buyAgain ? "Yes" : "No")
                        Image(systemName: bean.buyAgain ? SFSymbols.thumbsup : SFSymbols.thumbsdown)
                    }.padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .background(bean.buyAgain ? Color.green : Color.red)
                        .cornerRadius(10)
                }.padding(.vertical)
                GroupBox {
                    HStack {
                        Text("Notes")
                        Spacer()
                    }
                    HStack {
                        Text(bean.notes)
                            .lineLimit(nil)
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
            //            HStack {
            //                Button {
            //                    print("EDIT")
            //                } label: {
            //                    Image(systemName: SFSymbols.pencil)
            //                        .padding(.leading)
            //                    Text("Edit")
            //                        .padding(.trailing)
            //                }.buttonStyle(BorderedButtonStyle())
            //                    .padding(.bottom)
            //
            //                Spacer()
            //
            //                Button {
            //                    print("Delete")
            //                } label: {
            //                    Image(systemName: SFSymbols.trash)
            //                        .padding(.leading)
            //                    Text("Delete")
            //                        .padding(.trailing)
            //                }.buttonStyle(BorderedButtonStyle())
            //                    .foregroundColor(.red)
            //                    .padding(.bottom)
            //            }
        }.padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {print("show editView")}) {
                        Image(systemName: SFSymbols.pencil)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
