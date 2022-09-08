//
//  AboutView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/18/22.
//

import SwiftUI

struct AboutView: View {

    @Environment(\.colorScheme) private var colorScheme
    @State private var showingSheet = false
    @State private var showFeedback = false
    @State private var showingWhatsNew = false

    var body: some View {
        ScrollView {
            BuyDevCoffeeSection().padding()
            ShareApp().padding()
            Button {
                guard let writeReviewURL = URL(string: "https://apps.apple.com/us/app/coffee/id1611166034?action=write-review")
                        else { fatalError("Expected a valid URL") }
                UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: SFSymbols.starLeadingHalfFilled)
                        .foregroundColor(.pink)
                        .font(.system(size: 36))
                    Text("Leave Review")
                        .foregroundColor(.primary)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .row().padding()
            }
            Button {
                showFeedback = true
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: SFSymbols.plane)
                        .foregroundColor(.pink)
                        .font(.system(size: 36))
                    Text("Send feedback")
                        .foregroundColor(.primary)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .row().padding()

            }.sheet(isPresented: $showFeedback) {
                UserFeedbackView()
            }
            Button {
                showingWhatsNew = true
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: SFSymbols.star)
                        .foregroundColor(.pink)
                        .font(.system(size: 36))
                    Text("Release Notes")
                        .foregroundColor(.primary)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .row().padding()

            }.sheet(isPresented: $showingWhatsNew) {
                WhatsNewView()
            }

            HStack {
                Spacer()
                    .frame(height: 120)
            }
        }.safeAreaInset(edge: .top) {
            VStack(alignment: .center, spacing: 8) {
                HStack {
                    Text("About")
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                }
            }
            .padding()
            .background(.ultraThinMaterial)
        }.navigationBarHidden(true)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            .preferredColorScheme(.dark)
        AboutView()
            .preferredColorScheme(.light)
    }
}
