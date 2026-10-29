//
//  Analytics.swift
//  CoffeeTracker
//

import Foundation
import TelemetryDeck

/// Every TelemetryDeck signal the app sends. Parameters never include anything the user typed.
enum Analytics {
    case appOpened(libraryCount: Int)

    case coffeeAdded(BeanModel)
    case coffeeAddCancelled
    case coffeeEdited
    case coffeeDeleted
    /// Fires when the share sheet opens for a coffee's share image
    case coffeeShared

    case tipJarOpened
    case tipJarPurchased
    case tipJarCancelled

    case appShareTapped
    case reviewTapped
    case feedbackOpened
    case feedbackSubmitted(type: String)
    case releaseNotesViewed(source: ReleaseNotesSource)

    case reviewPromptShown(trigger: ReviewPromptService.Trigger)
    case reviewPromptReviewTapped
    case reviewPromptFeedbackTapped
    case reviewPromptFeedbackSubmitted
    case reviewPromptDismissed

    enum ReleaseNotesSource: String {
        case auto
        case menu
    }

    static func configure() {
        let config = TelemetryDeck.Config(appID: APIKeys.telemetryDeckAppID,
                                          namespace: APIKeys.telemetryDeckNamespace)
        TelemetryDeck.initialize(config: config)
    }

    func send() {
        TelemetryDeck.signal(name, parameters: parameters)
    }

    var name: String {
        switch self {
        case .appOpened: return "app.opened"
        case .coffeeAdded: return "coffee.added"
        case .coffeeAddCancelled: return "coffee.addCancelled"
        case .coffeeEdited: return "coffee.edited"
        case .coffeeDeleted: return "coffee.deleted"
        case .coffeeShared: return "coffee.shared"
        case .tipJarOpened: return "tipJar.opened"
        case .tipJarPurchased: return "tipJar.purchased"
        case .tipJarCancelled: return "tipJar.cancelled"
        case .appShareTapped: return "app.shareTapped"
        case .reviewTapped: return "review.tapped"
        case .feedbackOpened: return "feedback.opened"
        case .feedbackSubmitted: return "feedback.submitted"
        case .releaseNotesViewed: return "releaseNotes.viewed"
        case .reviewPromptShown: return "reviewPrompt.shown"
        case .reviewPromptReviewTapped: return "reviewPrompt.reviewTapped"
        case .reviewPromptFeedbackTapped: return "reviewPrompt.feedbackTapped"
        case .reviewPromptFeedbackSubmitted: return "reviewPrompt.feedbackSubmitted"
        case .reviewPromptDismissed: return "reviewPrompt.dismissed"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .appOpened(let libraryCount):
            return ["libraryBucket": Self.libraryBucket(for: libraryCount)]
        case .coffeeAdded(let coffee):
            return [
                "beanType": coffee.beanType,
                "hasPhoto": String(coffee.hasPhoto),
                "buyAgain": String(coffee.buyAgain),
                "hasNotes": String(!coffee.notes.isEmpty)
            ]
        case .feedbackSubmitted(let type):
            return ["type": type]
        case .releaseNotesViewed(let source):
            return ["source": source.rawValue]
        case .reviewPromptShown(let trigger):
            return ["trigger": trigger.rawValue]
        default:
            return [:]
        }
    }

    /// Buckets the library size so exact counts are never sent
    static func libraryBucket(for count: Int) -> String {
        switch count {
        case 0: return "0"
        case 1...5: return "1-5"
        case 6...20: return "6-20"
        default: return "21+"
        }
    }
}
