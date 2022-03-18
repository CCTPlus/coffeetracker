//
//  BuyDevCoffeeSection.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/18/22.
//

import SwiftUI

struct BuyDevCoffeeSection: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Image(systemName: SFSymbols.coffee)
                    .font(.title2)
                Text("Coffee fund")
                    .font(.title2).bold()
            }
            HStack {
                Text("Cups purchased")
                    .font(.headline)
                Spacer()
                Text("1")
            }
            HStack {
                Text("Amount spent")
                    .font(.headline)
                Spacer()
                Text("$3.99")
            }
            Button {
                print("Buy a cup of coffee")
            } label: {
                Text("Buy the dev a cup of coffee")
                    .foregroundColor(.primary)
                    .padding(5)
            }.buttonStyle(.bordered)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .shadow(radius: 2))
            Text("This just shows support to Maegan and helps the app continue to be developed in the wee hours of the morning and the evening.")
                .font(.caption2)
                .foregroundColor(.secondary)
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.quaternary)
            )
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 0.5)
                .shadow(color: .secondary, radius: 2, x: 0, y: 0))
    }
}

struct BuyDevCoffeeSection_Previews: PreviewProvider {
    static var previews: some View {
        BuyDevCoffeeSection().preferredColorScheme(.dark).padding()
    }
}
