import os
import SwiftUI

private let logger = Logger(subsystem: "CoffeeTracker", category: "ReviewPrompt")

struct ReviewFeedbackView: View {
  @Environment(\.dismiss) private var dismiss

  @State private var feedback = ""
  @State private var email = ""
  @State private var state: SubmitState = .idle
  @State private var showingError = false

  private var trimmedFeedback: String {
    feedback.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  private var trimmedEmail: String? {
    let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.isEmpty ? nil : trimmed
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextEditor(text: $feedback)
            .frame(minHeight: 160)
        } header: {
          Text("What could be better?")
        }

        Section {
          TextField("Email (optional)", text: $email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        } footer: {
          Text("Add your email if you'd like a reply.")
        }
      }
      .navigationTitle("Share feedback")
      .navigationBarTitleDisplayMode(.inline)
      .alert("Couldn't send feedback", isPresented: $showingError) {
        Button("OK", role: .cancel) {}
      } message: {
        Text("Please try again.")
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel", role: .close) {
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          if state == .sending {
            ProgressView()
          } else {
              Button("Send", systemImage: "paperplane", role: .confirm) {
                  submit()
              }
              .disabled(trimmedFeedback.isEmpty)
          }
        }
      }
    }
  }

  private func submit() {
    let details = trimmedFeedback
    state = .sending
    Task {
      do {
        try await FormspreeFeedback.submit(type: "feedback", message: details, email: trimmedEmail)
        Analytics.reviewPromptFeedbackSubmitted.send()
        dismiss()
      } catch {
        logger.error("Failed to submit review prompt feedback: \(error.localizedDescription)")
        state = .idle
        showingError = true
      }
    }
  }

  private enum SubmitState {
    case idle
    case sending
  }
}

#Preview {
  ReviewFeedbackView()
}
