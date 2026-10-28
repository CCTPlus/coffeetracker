//
//  BuyDevCoffeeSection.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 3/18/22.
//

import RevenueCat
import StoreKit
import SwiftUI

struct BuyDevCoffeeSection: View {
  /// Shows a close button in the corner when set.
  var onClose: (() -> Void)?

  @State private var package: Package?
  @State private var cupsPurchased = 0

  private let paper = Color(red: 0.97, green: 0.97, blue: 0.96)

  var price: String {
    guard let package = package else {
      return "—"
    }
    return package.storeProduct.localizedPriceString
  }

  var amount: String {
    let unitPrice = package.map { Double(truncating: $0.storeProduct.priceDecimalNumber) } ?? 0
    let total = Double(cupsPurchased) * unitPrice
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter.string(from: total as NSNumber)!
  }

  var body: some View {
    VStack(spacing: 16) {
      header
      DottedDivider()
      lineItem
      DottedDivider()
      total
      buyButton
      Text("One-time tip. No physical item or extra features.")
        .font(.caption)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .fixedSize()
      DottedDivider()
      supportSoFar
      DottedDivider()
      Text("Thank you for supporting independent development.")
        .font(.caption)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .fixedSize()
    }
    .padding(.horizontal, 28)
    .padding(.top, 32)
    .padding(.bottom, 36)
    .frame(maxWidth: .infinity)
    .background(paper)
    .clipShape(ReceiptShape())
    .overlay(alignment: .topTrailing) {
      if let onClose {
        Button(action: onClose) {
          Image(systemName: SFSymbols.xmark)
            .font(.body.weight(.semibold))
            .foregroundStyle(.secondary)
            .frame(width: 36, height: 36)
            .background(Color.black.opacity(0.08), in: Circle())
        }
        .accessibilityLabel("Close")
        .padding(12)
      }
    }
    .shadow(color: .black.opacity(0.15), radius: 12, y: 4)
    .environment(\.colorScheme, .light)
    .onAppear {
      Purchases.shared.getOfferings { (offerings, _) in
        if let packages = offerings?.current?.availablePackages {
          for package in packages {
            self.package = package
          }
          getAllPurchases()
        }
      }
    }
  }

  private var header: some View {
    VStack(spacing: 8) {
      Image(systemName: SFSymbols.coffeeSteaming)
        .font(.system(size: 48, weight: .light))
        .foregroundStyle(.primary)
      Text("COFFEE BREAK")
        .font(.system(.subheadline, design: .monospaced))
        .tracking(4)
        .padding(.bottom, 4)
      Text("Buy Jay a coffee")
        .font(.largeTitle.bold())
      Text("Support future development\nwith an optional tip.")
        .font(.subheadline)
        .fixedSize()
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
    }
  }

  private var lineItem: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack {
        Text("1 × Coffee")
        Spacer()
        Text(price)
      }
      .font(.system(.body, design: .monospaced))
      Text("A small thank-you for the developer.")
        .font(.system(.caption, design: .monospaced))
        .fixedSize()
        .foregroundStyle(.secondary)
    }
  }

  private var total: some View {
    HStack {
      Text("Total")
      Spacer()
      Text(price)
    }
    .font(.system(.body, design: .monospaced).bold())
  }

  private var buyButton: some View {
    Button {
      guard let package else { return }
      Purchases.shared.purchase(package: package) { _, _, error, userCancelled in
        if error == nil && userCancelled == false {
          cupsPurchased += 1
        }
      }
    } label: {
      Text(package == nil ? "Buy a coffee" : "Buy a coffee · \(price)")
        .font(.body.weight(.semibold))
        .foregroundStyle(.black)
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(Color.green.opacity(0.75), in: RoundedRectangle(cornerRadius: 10))
    }
    .disabled(package == nil)
  }

  private var supportSoFar: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("YOUR SUPPORT SO FAR")
        .font(.system(.caption, design: .monospaced))
        .tracking(1)
        .foregroundStyle(.secondary)
      HStack {
        Text("Coffees purchased")
        Spacer()
        Text("\(cupsPurchased)")
      }
      HStack {
        Text("Total tipped")
        Spacer()
        Text(amount)
      }
    }
    .font(.system(.subheadline, design: .monospaced))
  }

  func getPackagePrice(_ package: Package?) -> String {
    guard let package = package else {
      return "price not available"
    }

    return package.localizedPriceString
  }

  func getAllPurchases() {
    Purchases.shared.getCustomerInfo { customerInfo, _ in
      guard let customerInfo = customerInfo else {
        return
      }

      for transaction in customerInfo.nonSubscriptions {
        print(transaction.productIdentifier)
        if package?.storeProduct.productIdentifier == transaction.productIdentifier {
          cupsPurchased += 1
        }
      }
    }
  }
}

private struct DottedDivider: View {
  var body: some View {
    Line()
      .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 3]))
      .foregroundStyle(.secondary)
      .frame(height: 1)
  }

  private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
      var path = Path()
      path.move(to: CGPoint(x: rect.minX, y: rect.midY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
      return path
    }
  }
}

/// A receipt with rounded top corners and a torn, zigzag bottom edge.
private struct ReceiptShape: Shape {
  var cornerRadius: CGFloat = 16
  var toothWidth: CGFloat = 10
  var toothHeight: CGFloat = 6

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let bottom = rect.maxY - toothHeight

    path.move(to: CGPoint(x: rect.minX, y: bottom))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
    path.addQuadCurve(
      to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
      control: CGPoint(x: rect.minX, y: rect.minY)
    )
    path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
    path.addQuadCurve(
      to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius),
      control: CGPoint(x: rect.maxX, y: rect.minY)
    )
    path.addLine(to: CGPoint(x: rect.maxX, y: bottom))

    let teeth = max(1, Int((rect.width / toothWidth).rounded()))
    let step = rect.width / CGFloat(teeth)
    for tooth in 0..<teeth {
      let startX = rect.maxX - CGFloat(tooth) * step
      path.addLine(to: CGPoint(x: startX - step / 2, y: rect.maxY))
      path.addLine(to: CGPoint(x: startX - step, y: bottom))
    }
    path.closeSubpath()
    return path
  }
}

#Preview("Dark") {
  ZStack {
    Image("Background")
      .resizable()
      .ignoresSafeArea()
    BuyDevCoffeeSection(onClose: {}).padding()
  }
  .preferredColorScheme(.dark)
}

#Preview("Light") {
  ZStack {
    Image("Background")
      .resizable()
      .ignoresSafeArea()
    BuyDevCoffeeSection(onClose: {}).padding()
  }
  .preferredColorScheme(.light)
}
