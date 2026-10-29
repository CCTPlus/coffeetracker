import Foundation
import Observation
import os

private let logger = Logger(subsystem: "CoffeeTracker", category: "ReviewPrompt")

protocol ReviewPromptStore: AnyObject {
  func object(forKey key: String) -> Any?
  func set(_ value: Any?, forKey key: String)
  func synchronize() -> Bool
}

extension NSUbiquitousKeyValueStore: ReviewPromptStore {}

@MainActor
@Observable
final class ReviewPromptService {
  enum Trigger: String {
    case whatsNew
    case coffeeAdded
    case coffeeShared
  }

  enum Keys {
    static let lastPromptedAt = "reviewPrompt.lastPromptedAt"
    static let lastReviewedAt = "reviewPrompt.lastReviewedAt"
    static let lastReviewedVersion = "reviewPrompt.lastReviewedVersion"
    static let lastFeedbackAt = "reviewPrompt.lastFeedbackAt"
  }

  static let promptCooldownWeeks = 4
  static let reviewCooldownWeeks = 12

  @ObservationIgnored private let store: ReviewPromptStore
  @ObservationIgnored private let appVersion: String
  @ObservationIgnored private let now: () -> Date
  @ObservationIgnored private let calendar = Calendar(identifier: .gregorian)

  init(
    store: ReviewPromptStore = NSUbiquitousKeyValueStore.default,
    appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "",
    now: @escaping () -> Date = Date.init
  ) {
    self.store = store
    self.appVersion = appVersion
    self.now = now
    if !store.synchronize() {
      logger.error("Failed to synchronize review prompt state with iCloud key-value storage")
    }
  }

  var canPrompt: Bool {
    if let lastReviewedVersion = store.object(forKey: Keys.lastReviewedVersion) as? String,
       lastReviewedVersion == appVersion {
      return false
    }
    if isWithin(weeks: Self.reviewCooldownWeeks, of: Keys.lastReviewedAt)
        || isWithin(weeks: Self.reviewCooldownWeeks, of: Keys.lastFeedbackAt) {
      return false
    }
    return !isWithin(weeks: Self.promptCooldownWeeks, of: Keys.lastPromptedAt)
  }

  func promptIfEligible(after trigger: Trigger) -> Bool {
    guard canPrompt else { return false }
    store.set(now(), forKey: Keys.lastPromptedAt)
    Analytics.reviewPromptShown(trigger: trigger).send()
    return true
  }

  func recordReviewed() {
    store.set(now(), forKey: Keys.lastReviewedAt)
    store.set(appVersion, forKey: Keys.lastReviewedVersion)
  }

  func recordFeedbackStarted() {
    store.set(now(), forKey: Keys.lastFeedbackAt)
  }

  private func isWithin(weeks: Int, of key: String) -> Bool {
    guard let date = store.object(forKey: key) as? Date,
          let cutoff = calendar.date(byAdding: .weekOfYear, value: -weeks, to: now()) else {
      return false
    }
    return date > cutoff
  }
}
