//
//  CoffeeTrackerMain.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct CoffeeTrackerMain: View {
    @State private var showButtons = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            BeansCollectionView()
            Button(action: {showButtons.toggle()}) {
                Image(systemName: SFSymbols.plus)
                    .padding(12)
                    .background(Circle().fill(showButtons ? Color.red : Color.green)).shadow(radius: 8, x: 4, y: 4)
                    .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
            }.padding(20)
            .tint(.white)
            .animation(.default, value: showButtons)
        }
    }
}

struct CoffeeTrackerMain_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeTrackerMain()
    }
}
