//
//  BeanRowViewModel.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 4/6/22.
//

import SwiftUI

final class BeanRowViewOO: ObservableObject {
    @Published var showDetails = false

    let bean: BeanModel

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

    var hasPhoto: Bool {
        bean.hasPhoto
    }

    var beanTypeName: String {
        switch bean.beanType {
        case "beans":
            return "Whole bean"
        default:
            return bean.beanType.capitalized
        }
    }

    /// Style and bean type combined, e.g. "Dark roast · Grounds"
    var metadata: String {
        [bean.style, beanTypeName]
            .filter { !$0.isEmpty }
            .joined(separator: " · ")
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
