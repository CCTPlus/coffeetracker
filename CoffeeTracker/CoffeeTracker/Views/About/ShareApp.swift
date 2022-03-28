//
//  ShareApp.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/21/22.
//

import SwiftUI

struct ShareApp: View {

    @Environment(\.colorScheme) private var colorScheme
    @State private var showingSheet = false

    var body: some View {
        Button {
            showingSheet = true
        } label: {
            HStack(spacing: 15) {
                Image(systemName: SFSymbols.share)
                    .foregroundColor(.pink)
                    .font(.system(size: 36))
                Text("Share coffee_ with someone")
                    .foregroundColor(.primary)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .row()
        }
        .sheet(isPresented: $showingSheet) {
            ActivityView(activityItems: [NSURL(string: "https://apps.apple.com/us/app/coffee/id1611166034")!] as [Any], applicationActivities: nil)
        }

    }
}

struct ShareApp_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            ShareApp()
                .padding()
        }
    }
}
