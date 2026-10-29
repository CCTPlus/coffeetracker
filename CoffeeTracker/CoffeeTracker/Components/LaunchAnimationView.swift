//
//  LaunchAnimationView.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 10/29/26.
//

import SwiftUI

struct LaunchAnimationView: View {
  let isReady: Bool
  let onFinished: () -> Void

  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @State private var ready = false
  @State private var beanDropped = false
  @State private var bagSquashed = false
  @State private var dismissing = false

  private let bagSize: CGFloat = 160
  private let beanSize: CGFloat = 80

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        Color.canvas
        if !reduceMotion {
          Image("LaunchBean")
            .resizable()
            .frame(width: beanSize, height: beanSize)
            .rotationEffect(.degrees(beanDropped ? 25 : -35))
            .offset(y: beanDropped ? -bagSize * 0.1 : -(proxy.size.height + beanSize) / 2)
        }
        Image("LaunchBag")
          .resizable()
          .frame(width: bagSize, height: bagSize)
          .scaleEffect(x: bagSquashed ? 1.06 : 1, y: bagSquashed ? 0.92 : 1, anchor: .bottom)
      }
      .frame(width: proxy.size.width, height: proxy.size.height)
    }
    .ignoresSafeArea()
    .scaleEffect(dismissing && !reduceMotion ? 1.15 : 1)
    .opacity(dismissing ? 0 : 1)
    .accessibilityHidden(true)
    .onChange(of: isReady, initial: true) { _, newValue in
      ready = newValue
      if newValue && reduceMotion {
        Task { await dismiss() }
      }
    }
    .task {
      guard !reduceMotion else { return }
      repeat {
        await dropBean()
      } while !ready && !Task.isCancelled
      await dismiss()
    }
  }

  private func dropBean() async {
    beanDropped = false
    await animate(.easeIn(duration: 0.45)) { beanDropped = true }
    await animate(.easeOut(duration: 0.08)) { bagSquashed = true }
    await animate(.spring(duration: 0.2, bounce: 0.5)) { bagSquashed = false }
  }

  private func dismiss() async {
    await animate(.easeIn(duration: 0.25)) { dismissing = true }
    onFinished()
  }

  private func animate(_ animation: Animation, _ changes: @escaping () -> Void) async {
    await withCheckedContinuation { continuation in
      withAnimation(animation, changes) {
        continuation.resume()
      }
    }
  }
}

#Preview {
  LaunchAnimationView(isReady: false) {}
}
