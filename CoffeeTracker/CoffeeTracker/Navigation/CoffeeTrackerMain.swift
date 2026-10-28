//
//  CoffeeTrackerMain.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 2/21/22.
//

import CoreData
import SwiftUI

struct CoffeeTrackerMain: View {
  @AppStorage("lastSeenVersion") var lastSeenVersion: String?

  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.openURL) private var openURL

  @State private var showingNewBean = false
  @State private var showingDevCoffee = false
  @State private var showingShare = false
  @State private var showingFeedback = false
  @State private var showingReleaseNotes = false
  @State private var showNewView = false
  private let releaseNotes = ReleaseNotes.current()
  @StateObject var beanOO = NewBeanOO(bean: nil)

  var body: some View {
    NavigationStack {
      CoffeeListView()
        .popover(isPresented: $showNewView) {
          WhatsNewView(notes: releaseNotes)
        }
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Menu {
              Button {
                withAnimation {
                  showingDevCoffee = true
                }
              } label: {
                Label("Buy the developer a coffee", systemImage: SFSymbols.coffee)
              }
              Button {
                showingShare = true
              } label: {
                Label("Share coffee_", systemImage: SFSymbols.share)
              }
              Button {
                guard let writeReviewURL = URL(string: Urls.review) else { return }
                openURL(writeReviewURL)
              } label: {
                Label("Leave Review", systemImage: SFSymbols.starLeadingHalfFilled)
              }
              Button {
                showingFeedback = true
              } label: {
                Label("Send Feedback", systemImage: SFSymbols.plane)
              }
              Button {
                showingReleaseNotes = true
              } label: {
                Label("Release Notes", systemImage: SFSymbols.star)
              }
            } label: {
              Label("More", systemImage: SFSymbols.ellipsis)
            }
          }
          ToolbarSpacer(.fixed, placement: .topBarTrailing)
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              showingNewBean = true
            } label: {
              Label("Add Coffee", systemImage: SFSymbols.plus)
            }
            .buttonStyle(.glassProminent)
          }
        }
        .sheet(isPresented: $showingShare) {
          ActivityView(
            activityItems: [NSURL(string: Urls.appStore)!] as [Any],
            applicationActivities: nil
          )
        }
        .sheet(isPresented: $showingFeedback) {
          UserFeedbackView()
        }
        .sheet(isPresented: $showingReleaseNotes) {
          WhatsNewView(notes: releaseNotes)
        }
        .sheet(isPresented: $showingNewBean) {
          NavigationStack {
            NewBeansView()
              .environmentObject(beanOO)
              .navigationTitle("New Coffee")
              .navigationBarTitleDisplayMode(.inline)
          }
        }
        .onAppear {
          let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
          guard let currentVersion = currentVersion else {
            return
          }
          // Only show after an update, and only when this version has notes. Fresh installs skip it.
          if let lastSeenVersion, lastSeenVersion != currentVersion, releaseNotes != nil {
            showNewView = true
          }
          lastSeenVersion = currentVersion
        }
    }
    .overlay {
      if showingDevCoffee {
        ZStack {
          Color.black.opacity(0.3)
            .ignoresSafeArea()
            .onTapGesture {
              withAnimation {
                showingDevCoffee = false
              }
            }
            .accessibilityLabel("Close")
            .accessibilityAddTraits(.isButton)
          BuyDevCoffeeSection()
            .background(Color.canvas.opacity(0.3), in: RoundedRectangle(cornerRadius: 10))
            .padding()
        }
        .transition(.opacity)
      }
    }
  }
}

#Preview {
  CoffeeTrackerMain()
    .environmentObject(
      BeansCollectionViewOO(context: PersistenceController.preview.container.viewContext)
    )
}
