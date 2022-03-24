//
//  RowModifier.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/23/22.
//

import Foundation
import SwiftUI

struct RowModifier: ViewModifier {

    @Environment(\.colorScheme) private var colorScheme

    var padding = true
    
    func body(content: Content) -> some View {
        content
            .padding(.all, padding ? 10 : 0)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.black.opacity(0.5), lineWidth: 0.5))
            .shadow(radius: 20)
    }
}
