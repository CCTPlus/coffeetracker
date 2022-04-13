//
//  NewBeanOO.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 4/8/22.
//

import Foundation
import SwiftUI

final class NewBeanOO: ObservableObject {
    @Environment(\.colorScheme) private var colorScheme

    @Published var coffee: BeanModel

    var isEditing: Bool
    /// Yes Button Foreground Color
    var yesButtonFGColor: Color {
        coffee.buyAgain ? .black : .accentColor
    }
    /// Yes Button Foreground Color
    var yesButtonBGColor: Color {
        coffee.buyAgain ? .accentColor : .clear
    }
    /// No Button Foreground Color
    var noButtonFGColor: Color {
        coffee.buyAgain ? .accentColor : .black
    }
    /// No Button Background Color
    var noButtonBGColor: Color {
        coffee.buyAgain ? .clear : .accentColor
    }

    init(bean: BeanModel?) {
        guard let bean = bean else {
            isEditing = false
            coffee = BeanModel(name: "",
                      style: "",
                      buyAgain: false,
                      roaster: "",
                      roastedOn: Date(),
                      boughtOn: Date(),
                      notes: "",
                      beanType: "beans",
                      image: UIImage())
            return
        }
        isEditing = true
        coffee = bean
    }
}
