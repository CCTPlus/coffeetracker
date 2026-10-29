import SwiftUI

struct FeedbackSentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(.white, .green)
            Text("Your feedback has been sent and the developer will review it shortly.")
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: 320)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
        .compositingGroup()
        .shadow(radius: 12)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    FeedbackSentView()
}
