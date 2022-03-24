//
//  TabBarIcon.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/23/22.
//

import SwiftUI

struct TabBarIcon: View {
    @StateObject var navRouter: NavigationRouter

    let assignedPage: Page

    let width, height: CGFloat
    let systemIcon, tabName: String

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
        }.foregroundColor(assignedPage == navRouter.currentPage ? Color.blue : Color.primary)
            .onTapGesture {
            navRouter.currentPage = assignedPage
        }
    }
}

struct TabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        TabBarIcon(navRouter: NavigationRouter(), assignedPage: .coffees, width: 100, height: 100, systemIcon: SFSymbols.list, tabName: "Coffee")
    }
}