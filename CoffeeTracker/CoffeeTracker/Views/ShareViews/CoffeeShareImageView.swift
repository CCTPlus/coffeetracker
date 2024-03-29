//
//  CoffeeShareImageView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 4/14/22.
//

import SwiftUI

struct CoffeeShareImageView: View {
    @Binding var showBoughtDate: Bool
    @Binding var showRoastedDate: Bool
    @Binding var showNotes: Bool
    @Binding var showWatermark: Bool

    var coffee: BeanModel
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: Design.base*2) {
                Image(uiImage: coffee.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(Design.base)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.black.opacity(0.5), lineWidth: 0.5))
                    .frame(maxWidth: Design.base*10, maxHeight: Design.base*10, alignment: .topLeading)
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
            }
            Group {
                if showBoughtDate {
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
                }
                if showRoastedDate {
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
                }
                if showNotes {
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
                                .multilineTextAlignment(.leading)

                        }
                    }
                }
                if showWatermark {
                    HStack {
                        Spacer()
                        Text("Made with coffee_")
                            .font(.footnote)
                        Image("Launch")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                    }.opacity(0.5)
                }
            }.padding(.all, Design.base/2)
        }
            .padding(.all)
            .border(Color.black.opacity(0.5), width: 0.5)
        .background(Image("Background")
                .resizable())
    }
}

struct CoffeeShareImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShareImageView(showBoughtDate: .constant(true),
                             showRoastedDate: .constant(true),
                             showNotes: .constant(true),
                             showWatermark: .constant(true),
                             coffee: testRoast)
            .padding()
    }
}
