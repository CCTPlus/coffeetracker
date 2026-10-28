//
//  WhatsNewView.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 4/12/22.
//

import SwiftUI

struct WhatsNewView: View {
  let notes: ReleaseNotes?

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading) {
          if let notes {
            ForEach(notes.sections) { section in
              ReleaseNotesSection(section: section)
            }
          } else {
            Text("No release notes for this version.")
              .foregroundStyle(.secondary)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding()
              .row()
              .padding(.bottom)
          }
          BuyDevCoffeeSection()
        }
        .padding()
      }
      .navigationTitle(Text(notes.map { "What's new in v\($0.version)" } ?? "What's new"))
    }
  }
}

private struct ReleaseNotesSection: View {
  let section: ReleaseNotes.Section

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        icon
        Text(section.kind.title)
          .font(.title)
        Spacer()
      }
      ForEach(section.items, id: \.self) { item in
        HStack(alignment: .top) {
          Text("\u{2022}")
          Text(item)
        }
      }
    }
    .padding()
    .row()
    .padding(.bottom)
  }

  @ViewBuilder private var icon: some View {
    switch section.kind {
      case .features:
        Image(systemName: SFSymbols.star)
          .symbolVariant(.fill)
          .foregroundColor(.green)
      case .bugFixes:
        Image(systemName: SFSymbols.ladybug)
          .foregroundColor(.red)
      case .performance:
        Image(systemName: SFSymbols.bolt)
          .symbolVariant(.fill)
          .foregroundColor(.orange)
    }
  }
}

#Preview {
  ZStack {
    Image("Background")
      .resizable()
      .ignoresSafeArea()
    WhatsNewView(
      notes: ReleaseNotes(
        version: "1.2.0",
        sections: [
          .init(kind: .features, items: ["Redesign the main view"]),
          .init(kind: .bugFixes, items: ["Close new bean form on successful addition"]),
        ]
      )
    )
  }
  .preferredColorScheme(.dark)
}
