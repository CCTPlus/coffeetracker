import StoreKit
import SwiftUI

enum ReviewPromptChoice {
  case review
  case feedback
}

struct ReviewPromptView: View {
  @Binding var choice: ReviewPromptChoice?

  @Environment(\.dismiss) private var dismiss
  @Environment(ReviewPromptService.self) private var reviewPrompt

  var body: some View {
    NavigationStack {
      VStack(spacing: Design.base * 2) {
        Image(systemName: SFSymbols.coffeeSteaming)
          .font(.system(size: 56))
          .foregroundStyle(.brown)
        VStack(spacing: Design.base) {
          Text("Enjoying coffee_?")
            .font(.title2.bold())
          Text("A quick rating on the App Store helps other coffee lovers find the app.")
            .multilineTextAlignment(.center)
        }
        Spacer(minLength: 0)
        VStack(spacing: Design.base * 2) {
          Button {
            reviewPrompt.recordReviewed()
            Analytics.reviewPromptReviewTapped.send()
            choice = .review
            dismiss()
          } label: {
            Label("Leave a review", systemImage: SFSymbols.star)
                  .symbolVariant(.fill)
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.glassProminent)

          .controlSize(.large)

          Button("Not loving it? Share feedback") {
            reviewPrompt.recordFeedbackStarted()
            Analytics.reviewPromptFeedbackTapped.send()
            choice = .feedback
            dismiss()
          }
          .buttonStyle(.borderless)
          .font(.subheadline)
          .bold()
        }
      }
      .padding()
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Not now", role: .close) {
            Analytics.reviewPromptDismissed.send()
            dismiss()
          }
        }
      }
    }
    .presentationDetents([.medium])
  }
}

private struct ReviewPromptModifier: ViewModifier {
  @Binding var isPresented: Bool

  @Environment(\.requestReview) private var requestReview
  @State private var choice: ReviewPromptChoice?
  @State private var showingFeedback = false

  func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        switch choice {
        case .review:
          requestReview()
        case .feedback:
          showingFeedback = true
        case nil:
          break
        }
        choice = nil
      } content: {
        ReviewPromptView(choice: $choice)
      }
      .sheet(isPresented: $showingFeedback) {
        ReviewFeedbackView()
      }
  }
}

extension View {
  func reviewPrompt(isPresented: Binding<Bool>) -> some View {
    modifier(ReviewPromptModifier(isPresented: isPresented))
  }
}

#Preview {
  Color.clear
    .sheet(isPresented: .constant(true)) {
      ReviewPromptView(choice: .constant(nil))
    }
    .environment(ReviewPromptService())
}
