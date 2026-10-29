//
//  UserFeedback.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 3/21/22.
//

import os
import SwiftUI

private let logger = Logger(subsystem: "CoffeeTracker", category: "Feedback")

struct UserFeedbackView: View {
    @Environment(\.dismiss) private var dismiss

    var onSent: () -> Void = {}

    @State private var title: String = ""
    @State private var details: String = ""
    @State private var email: String = ""
    @State private var selectedFeedbackType: FeedbackType? = .bug
    @State private var state: SubmitState = .idle
    @State private var showingError = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Type", selection: $selectedFeedbackType) {
                        Text("Bug").tag(FeedbackType.bug)
                        Text("Feature Request").tag(FeedbackType.feature)
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
                } header: {
                    Text("Type")
                }

                Section {
                    TextField("Summary", text: $title)
                } header: {
                    Text("Summary")
                } footer: {
                    Text(summaryHint)
                }

                Section {
                    TextField("Steps or anything else that helps", text: $details, axis: .vertical)
                        .lineLimit(5...10)
                } header: {
                    Text("Feedback Details")
                }

                Section {
                    TextField("Email (optional)", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } header: {
                    Text("Email")
                } footer: {
                    Text("Add your email if you'd like a reply.")
                }
            }
            .navigationTitle("Feedback")
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
                            addIssueToGithub()
                        }
                        .disabled(trimmedTitle.isEmpty || selectedFeedbackType == nil)
                    }
                }
            }
        }
    }

    private var summaryHint: String {
        switch selectedFeedbackType {
        case .bug:
            "Describe what went wrong in one line, like \"The app crashes when I add a photo.\""
        case .feature:
            "Describe what you'd like in one line, like \"Let me sort coffees by roaster.\""
        case nil:
            "A one-line description of the bug or idea. Add the details below."
        }
    }

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedEmail: String? {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    private enum SubmitState {
        case idle
        case sending
    }

    private enum FeedbackType: String {
        case bug
        case feature = "enhancement"
    }

    private func addIssueToGithub() {
        guard let selectedFeedbackType else { return }
        state = .sending

        Task {
            do {
                let type = selectedFeedbackType == .bug ? "bug" : "feature"
                try await FormspreeFeedback.submit(
                    type: type,
                    message: details.trimmingCharacters(in: .whitespacesAndNewlines),
                    summary: trimmedTitle,
                    email: trimmedEmail
                )
                Analytics.feedbackSubmitted(type: type).send()
                onSent()
                dismiss()
            } catch {
                logger.error("Failed to submit feedback: \(error.localizedDescription)")
                state = .idle
                showingError = true
            }
        }
    }
}

#Preview {
    UserFeedbackView()
}
