//
//  AboutView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/18/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            BuyDevCoffeeSection()
        }.padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
