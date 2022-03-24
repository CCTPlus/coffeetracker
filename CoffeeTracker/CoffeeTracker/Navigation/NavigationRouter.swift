//
//  NavigationRouter.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/23/22.
//

import Foundation

class NavigationRouter: ObservableObject {
    @Published var currentPage: Page = .coffees
}

enum Page {
    case coffees, info, newBeans
}
