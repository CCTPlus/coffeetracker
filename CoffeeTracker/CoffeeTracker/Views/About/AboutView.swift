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

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                        .frame(height: 70)
                }
                ScrollView {
                    BuyDevCoffeeSection().padding()
                    ShareApp().padding()
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

                    HStack {
                        Spacer()
                            .frame(height: 120)
                    }
                }
            }
            Group {
                GeometryReader { geometry in
                    HStack(alignment: .bottom) {
                        Text("About")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 10)
                            .padding(.leading)
                        Spacer()
                    }
                    .frame(height: geometry.safeAreaInsets.top+80)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10, corners: .bottomLeft)
                    .cornerRadius(10, corners: .bottomRight)
                    .edgesIgnoringSafeArea(.top)
                }
            }.shadow(radius: 2)
        }
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
