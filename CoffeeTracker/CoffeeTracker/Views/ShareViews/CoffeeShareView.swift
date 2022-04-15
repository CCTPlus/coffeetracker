//
//  CoffeeShareView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 4/14/22.
//

import SwiftUI

struct CoffeeShareView: View {

    @State private var showingShare = false
    @State private var shareImage: [Any] = []
    @State private var showBoughtDate: Bool = true
    @State private var showRoastedDate: Bool = true
    @State private var showNotes: Bool = true

    var coffee: BeanModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Share \(coffee.name)")
                .font(.largeTitle)
                .bold()

        // View to share
            CoffeeShareImageView(showBoughtDate: $showBoughtDate,
                                 showRoastedDate: $showRoastedDate,
                                 showNotes: $showNotes,
                                 coffee: coffee)
            .padding()
            Spacer()
            Group {
                Text("The options to adjust view will go here")
            }
            Button {
                let image = CoffeeShareImageView(showBoughtDate: $showBoughtDate,
                                                 showRoastedDate: $showRoastedDate,
                                                 showNotes: $showNotes,
                                                 coffee: coffee).snapshot()
                shareImage.append(image)
                showingShare.toggle()
            } label: {
                Image(systemName: SFSymbols.share)
                Text("Share")
            }
        }.sheet(isPresented: $showingShare) {
            ActivityView(activityItems: shareImage, applicationActivities: nil)
                .onDisappear {
                    shareImage = []
                }
        }
    }
}

struct CoffeeShareView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShareView(coffee: testRoast)
    }
}
