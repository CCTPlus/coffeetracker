//
//  WhatsNewView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 4/12/22.
//

import SwiftUI

struct WhatsNewView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("What's new in v1.1")
                    .font(.largeTitle)
                    .bold()
                // Features
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: SFSymbols.star)
                            .foregroundColor(.green)
                        Text("Features")
                            .font(.title)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        Text("\u{2022}")
                        Text("Share your coffee information as a picture")
                    }
                    HStack(alignment: .top) {
                        Text("\u{2022}")
                        Text("Coffee categories")
                    }
                    HStack(alignment: .top) {
                        Text("\u{2022}")
                        Text("Coffee Notes")
                    }.padding(.bottom)
                }.padding()
                .row()
                .padding(.bottom)
                // Bug Fixes
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: SFSymbols.ladybug)
                            .foregroundColor(.red)
                        Text("Bug Fixes")
                            .font(.title)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        Text("\u{2022}")
                        Text("Dev coffee cup counter now counts correctly")
                    }.padding(.bottom)
                }.padding()
                .row()
                .padding(.bottom)
                BuyDevCoffeeSection()
            }.padding()
        }
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            WhatsNewView()
        }.preferredColorScheme(.dark)
    }
}
