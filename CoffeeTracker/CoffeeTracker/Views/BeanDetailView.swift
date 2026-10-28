//
//  BeanDetailView.swift
//
//
//  Created by Jay Wilson on 2/21/22.
//

import SwiftUI

struct BeanDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var beanOO: NewBeanOO
    @State private var showEditView = false
    @State private var showShareView = false

    var body: some View {
        VStack(alignment: .leading, spacing: Design.base) {
            VStack(alignment: .leading, spacing: Design.base/2) {
                LabeledContent("Bought", value: beanOO.coffee.boughtOn.formatted(date: .abbreviated, time: .omitted))
                LabeledContent("Roasted", value: beanOO.coffee.roastedOn.formatted(date: .abbreviated, time: .omitted))
            }
            .font(.subheadline)

            if beanOO.coffee.notes.count > 0 {
                Text(beanOO.coffee.notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(nil)
            }

            HStack(spacing: Design.base) {
                Button { showEditView.toggle() } label: {
                    Label("Edit", systemImage: SFSymbols.pencil)
                }
                Button { showShareView.toggle() } label: {
                    Label("Share", systemImage: SFSymbols.share)
                }
                Spacer()
                Button(role: .destructive) { beanOO.coffee.deleteBean(context: viewContext) } label: {
                    Label("Delete", systemImage: SFSymbols.trash)
                        .labelStyle(.iconOnly)
                }
            }
            .buttonStyle(.borderless)
            .font(.subheadline.weight(.semibold))
            .padding(.top, Design.base/2)
        }
        .sheet(isPresented: $showShareView) {
            CoffeeShareView(coffee: beanOO.coffee)
        }
        .sheet(isPresented: $showEditView) {
            showEditView = false
        } content: {
            NewBeansView(beans: beanOO.coffee, isEdit: true)
                .environmentObject(beanOO)
        }
    }
}

#Preview {
    BeanDetailView(beanOO: NewBeanOO(bean: testRoast))
        .padding()
}
