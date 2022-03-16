//
//  CoffeeTrackerMain.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct CoffeeTrackerMain: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var showButtons = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            BeansCollectionView()
            if showButtons {
                NewBeansView(showForm: $showButtons)
                    .opacity(showButtons ? 1 : 0)
            }
            Button(action: {showButtons.toggle()}) {
                Image(systemName: SFSymbols.plus)
                    .padding(12)
                    .background(Circle().fill(showButtons ? Color.red : Color.sage)).shadow(radius: 8, x: 4, y: 4)
                    .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
            }.padding(20)
            .tint(.white)
        }
        .animation(.default, value: showButtons)
    }
}

struct CoffeeTrackerMain_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeTrackerMain()
    }
}
