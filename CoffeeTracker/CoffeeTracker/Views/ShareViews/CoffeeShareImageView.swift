//
//  CoffeeShareImageView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 4/14/22.
//

import SwiftUI

struct CoffeeShareImageView: View {
    var coffee: BeanModel
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: Design.base*2) {
                Image(uiImage: coffee.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(Design.base)
                    .frame(maxWidth: Design.base*10, maxHeight: Design.base*10, alignment: .top)
                VStack(alignment: .leading, spacing: Design.base/2) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(coffee.name)
                                .font(.headline)
                            Text(coffee.roaster)
                                .font(.subheadline)
                                .padding(.bottom, Design.base)
                        }
                        Spacer()
                        if coffee.buyAgain {
                            Image(systemName: SFSymbols.thumbsup)
                                .opacity(0.60)
                        }
                    }
                    HStack(alignment: .bottom) {
                        Text(coffee.style)
                            .font(.footnote)
                        Spacer()
                        switch coffee.beanType {
                        case "pods":
                            Image(systemName: SFSymbols.rectRoundedBottom)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.5)
                        case "grounds":
                            Image("CoffeeBag")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.5)
                        default:
                            Image("CoffeeBean")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.5)
                        }
                    }
                }
            }.padding(.horizontal, Design.base).padding(.top, Design.base)
                .padding(.bottom, Design.base)
            Group {
                HStack {
                    Text("Bought on")
                    Spacer()
                    Text(coffee.boughtOn.formatted(
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
                    Text(coffee.roastedOn.formatted(
                        .iso8601
                            .month()
                            .day()
                            .year()
                            .dateSeparator(.dash))
                    )
                }
                if coffee.notes.count > 0 {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Notes")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.bottom, Design.base/4)
                            Spacer()
                        }
                        Text(coffee.notes)
                            .lineLimit(nil)
                    }
                }
            }.padding(.all)
        }.row()
    }
}

struct CoffeeShareImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShareImageView(coffee: testRoast)
    }
}
