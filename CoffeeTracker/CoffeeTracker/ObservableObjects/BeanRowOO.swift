//
//  BeanRowViewModel.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 4/6/22.
//

import SwiftUI

final class BeanRowViewOO: ObservableObject {
    @Published var showDetails = false

    let bean: BeanModel

    var bottomPadding: CGFloat {
        if !showDetails {
            return Design.base
        } else {
            return 0
        }
    }

    var coffeeTypeIcon: Image {
        switch bean.beanType {
        case "pods":
            return Image(systemName: SFSymbols.rectRoundedBottom)
        case "grounds":
            return Image("CoffeeBag")
        default:
            return Image("CoffeeBean")
        }
    }

    var image: UIImage {
        bean.image
    }

    var name: String {
        bean.name
    }

    var roaster: String {
        bean.roaster
    }

    var buyAgain: Bool {
        bean.buyAgain
    }

    var style: String {
        bean.style
    }
    init(bean: BeanModel) {
        self.bean = bean
    }

    func toggleDetails() {
        showDetails.toggle()
    }
}
