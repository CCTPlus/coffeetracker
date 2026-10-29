//
//  CoffeeTrackerMain.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 2/21/22.
//

import CoreData
import KickstartExchange
import os
import RevenueCat
import SwiftUI

private let logger = Logger(subsystem: "CoffeeTracker", category: "Tips")

struct CoffeeTrackerMain: View {
  @AppStorage("lastSeenVersion") var lastSeenVersion: String?
  @AppStorage(ASKeys.hasTippedDev) private var hasTippedDev = false
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

  private var showsAds: Bool {
    #if DEBUG
    if ScreenshotSampleData.isEnabled { return false }
    #endif
    return !hasTippedDev
  }

  var body: some View {
    NavigationStack {
      CoffeeListView()
        .safeAreaInset(edge: .bottom) {
          if showsAds {
            ExchangeBannerAdView(apiKey: APIKeys.kickstartExchange)
              .padding(.horizontal)
          }
        }
        .sheet(isPresented: $showNewView) {
          WhatsNewView(notes: releaseNotes)
        }
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Menu {
              Button {
                Analytics.tipJarOpened.send()
                withAnimation {
                  showingDevCoffee = true
                }
              } label: {
                Label("Buy the dev a coffee", systemImage: SFSymbols.coffee)
              }
              Button {
                Analytics.appShareTapped.send()
                showingShare = true
              } label: {
                Label("Share coffee_", systemImage: SFSymbols.share)
              }
              Button {
                guard let writeReviewURL = URL(string: Urls.review) else { return }
                Analytics.reviewTapped.send()
                openURL(writeReviewURL)
              } label: {
                Label("Leave Review", systemImage: SFSymbols.starLeadingHalfFilled)
              }
              Button {
                Analytics.feedbackOpened.send()
                showingFeedback = true
              } label: {
                Label("Send Feedback", systemImage: SFSymbols.plane)
              }
              Button {
                Analytics.releaseNotesViewed(source: .menu).send()
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
            Analytics.releaseNotesViewed(source: .auto).send()
          }
          lastSeenVersion = currentVersion
        }
        .task {
          guard await TipHistory.coffeesPurchased() > 0 else { return }
          hasTippedDev = true
          do {
            _ = try await Purchases.shared.syncPurchases()
          } catch {
            logger.error("Failed to sync tips to RevenueCat: \(error.localizedDescription)")
          }
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
          BuyDevCoffeeSection {
            withAnimation {
              showingDevCoffee = false
            }
          }
          .padding(32)
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
