//
//  CoffeeShareView.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 4/14/22.
//

import SwiftUI

struct CoffeeShareView: View {
    @Environment(ReviewPromptService.self) private var reviewPrompt

    @State private var showingShare = false
    @State private var shareImage: [Any] = []
    @State private var showBoughtDate: Bool = true
    @State private var showRoastedDate: Bool = true
    @State private var showNotes: Bool = true
    @State private var showWatermark: Bool = true
    @State private var showingReviewPrompt = false

    var coffee: BeanModel
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // View to share
                    CoffeeShareImageView(showBoughtDate: $showBoughtDate,
                                         showRoastedDate: $showRoastedDate,
                                         showNotes: $showNotes,
                                         showWatermark: $showWatermark,
                                         coffee: coffee)
                    .padding()

                    Button {
                        let image = CoffeeShareImageView(showBoughtDate: $showBoughtDate,
                                                         showRoastedDate: $showRoastedDate,
                                                         showNotes: $showNotes,
                                                         showWatermark: $showWatermark,
                                                         coffee: coffee).asImage()
                        actionSheet(image: image)
                        Analytics.coffeeShared.send()
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: SFSymbols.share)
                            Text("Share")
                            Spacer()
                        }
                    }.padding()
                        .background(.tertiary)
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Group {
                        Toggle(isOn: $showBoughtDate) {
                            Text("Show bought Date")
                        }
                        Toggle(isOn: $showRoastedDate) {
                            Text("Show roasted Date")
                        }
                        Toggle(isOn: $showNotes) {
                            Text("Show notes")
                        }
                        Toggle(isOn: $showWatermark) {
                            Text("Show watermark")
                        }
                    }.padding(.horizontal)
                }
            }.navigationTitle(Text("Share \(coffee.name)"))
                .sheet(isPresented: $showingShare) {
                    ActivityView(activityItems: shareImage, applicationActivities: nil)
                        .onDisappear {
                            shareImage = []
                        }
                }
                .reviewPrompt(isPresented: $showingReviewPrompt)
        }
    }

    private func actionSheet(image: UIImage) {
        let imageToShare = [ image ] as [AnyObject]
        let activityVC = UIActivityViewController(activityItems: imageToShare as [AnyObject],
                                                  applicationActivities: nil)
        activityVC.completionWithItemsHandler = { _, completed, _, _ in
            guard completed else { return }
            showingReviewPrompt = reviewPrompt.promptIfEligible(after: .coffeeShared)
        }
        if let popOverController = activityVC.popoverPresentationController {
            popOverController.permittedArrowDirections = [.right]
        }
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(activityVC, animated: true, completion: nil)
            }
        }
    }
}

#Preview {
    CoffeeShareView(coffee: testRoast)
        .environment(ReviewPromptService())
}
