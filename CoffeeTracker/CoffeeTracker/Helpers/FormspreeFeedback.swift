import UIKit

enum FormspreeFeedback {
  private static let endpoint = URL(string: "https://formspree.io/f/mqpplnle")!

  struct SubmissionFailed: Error {
    let statusCode: Int
  }

  @MainActor
  static func submit(type: String, message: String, summary: String? = nil, email: String? = nil) async throws {
    var fields = [
      "_subject": "coffee_ \(type)",
      "type": type,
      "message": message,
      "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown",
      "appBuild": Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown",
      "osVersion": UIDevice.current.systemVersion,
      "deviceModel": UIDevice.current.model,
    ]
    if let summary {
      fields["summary"] = summary
    }
    if let email {
      fields["email"] = email
    }

    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = try JSONEncoder().encode(fields)

    let (_, response) = try await URLSession.shared.data(for: request)
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    guard (200..<300).contains(statusCode) else {
      throw SubmissionFailed(statusCode: statusCode)
    }
  }
}
