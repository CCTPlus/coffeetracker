import XCTest

@testable import Coffee_

private final class InMemoryReviewPromptStore: ReviewPromptStore {
  var values: [String: Any] = [:]

  func object(forKey key: String) -> Any? { values[key] }
  func set(_ value: Any?, forKey key: String) { values[key] = value }
  func synchronize() -> Bool { true }
}

@MainActor
class ReviewPromptServiceTests: XCTestCase {
  private var store: InMemoryReviewPromptStore!
  private var now: Date!

  override func setUp() {
    super.setUp()
    store = InMemoryReviewPromptStore()
    now = Date(timeIntervalSince1970: 1_800_000_000)
  }

  private func makeService(version: String = "1.2.0") -> ReviewPromptService {
    ReviewPromptService(store: store, appVersion: version, now: { [unowned self] in self.now })
  }

  private func advance(weeks: Int, days: Int = 0) {
    now = Calendar(identifier: .gregorian).date(byAdding: DateComponents(day: days, weekOfYear: weeks), to: now)
  }

  func testPromptsWithNoHistory() {
    XCTAssertTrue(makeService().promptIfEligible(after: .coffeeAdded))
  }

  func testPromptStartsFourWeekCooldown() {
    let service = makeService()
    XCTAssertTrue(service.promptIfEligible(after: .whatsNew))
    XCTAssertFalse(service.promptIfEligible(after: .coffeeAdded))

    advance(weeks: 3, days: 6)
    XCTAssertFalse(service.canPrompt)

    advance(weeks: 0, days: 1)
    XCTAssertTrue(service.canPrompt)
  }

  func testReviewStartsTwelveWeekCooldown() {
    makeService(version: "1.2.0").recordReviewed()
    let service = makeService(version: "1.3.0")

    advance(weeks: 11, days: 6)
    XCTAssertFalse(service.canPrompt)

    advance(weeks: 0, days: 1)
    XCTAssertTrue(service.canPrompt)
  }

  func testNeverPromptsOnReviewedVersion() {
    let service = makeService(version: "1.2.0")
    service.recordReviewed()

    advance(weeks: 52)
    XCTAssertFalse(service.canPrompt)
    XCTAssertTrue(makeService(version: "1.2.1").canPrompt)
  }

  func testFeedbackStartsTwelveWeekCooldownWithoutBlockingVersion() {
    let service = makeService()
    service.recordFeedbackStarted()

    advance(weeks: 11, days: 6)
    XCTAssertFalse(service.canPrompt)

    advance(weeks: 0, days: 1)
    XCTAssertTrue(service.canPrompt)
  }
}
