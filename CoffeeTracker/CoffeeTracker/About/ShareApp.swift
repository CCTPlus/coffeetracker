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
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .quaternary : .primary)
                )
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary, lineWidth: 0.5)
                    .shadow(color: .secondary, radius: 20, x: 0, y: 0))
        }
        .sheet(isPresented: $showingSheet) {
            ActivityView(activityItems: [NSURL(string: "https://cctplus.dev")!] as [Any], applicationActivities: nil)
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
