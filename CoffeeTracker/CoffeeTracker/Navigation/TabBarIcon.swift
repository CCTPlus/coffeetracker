//
//  TabBarIcon.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/23/22.
//

import SwiftUI

struct TabBarIcon: View {
    @Environment(\.colorScheme) private var colorScheme

    @StateObject var navRouter: NavigationRouter

    let assignedPage: Page

    let width, height: CGFloat
    let systemIcon, tabName: String

    /// Foreground color in light mode
    var lightFGColor: Color {
        if assignedPage == navRouter.currentPage {
            return .indigo
        } else {
            return .secondary
        }
    }

    /// Foreground color in dark mode
    var darkFGColor: Color {
        if assignedPage == navRouter.currentPage {
            return Color.cyan
        } else {
            return Color.secondary
        }
    }

    var body: some View {
        VStack {
            Image(systemName: systemIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }.foregroundColor(assignedPage == navRouter.currentPage ? .accentColor : .secondary)
            .onTapGesture {
                withAnimation {
                    navRouter.currentPage = assignedPage
                }
        }
    }
}

struct TabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        TabBarIcon(navRouter: NavigationRouter(),
                   assignedPage: .coffees,
                   width: 100,
                   height: 100,
                   systemIcon: SFSymbols.list,
                   tabName: "Coffee")
    }
}
