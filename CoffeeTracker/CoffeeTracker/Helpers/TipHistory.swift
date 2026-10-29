import os
import StoreKit

private let logger = Logger(subsystem: "CoffeeTracker", category: "Tips")

enum TipHistory {
  static func coffeesPurchased() async -> Int {
    var count = 0
    for await result in Transaction.all {
      switch result {
      case .verified(let transaction):
        if transaction.productType == .consumable, transaction.revocationDate == nil {
          count += 1
        }
      case .unverified(let transaction, let error):
        logger.error("Skipping unverified transaction \(transaction.id): \(error.localizedDescription)")
      }
    }
    return count
  }
}
