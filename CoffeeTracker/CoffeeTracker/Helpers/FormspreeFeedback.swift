import UIKit

enum FormspreeFeedback {
  private static let endpoint = URL(string: "https://formspree.io/f/mqpplnle")!

  struct SubmissionFailed: Error {
    let statusCode: Int
  }

  @MainActor
  static func submit(subject: String, message: String, email: String? = nil, type: String? = nil) async throws {
    var fields = [
      "_subject": subject,
      "message": message,
      "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown",
      "appBuild": Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown",
      "osVersion": UIDevice.current.systemVersion,
      "deviceModel": UIDevice.current.model,
    ]
    if let email {
      fields["email"] = email
    }
    if let type {
      fields["type"] = type
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
