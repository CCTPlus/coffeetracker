//
//  BuyDevCoffeeSection.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/18/22.
//

import SwiftUI
import RevenueCat

struct BuyDevCoffeeSection: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var package: Package? = nil
    @State private var cupsPurchased = 0

    var amount: Double {
        guard let package = package else {
            return 0.0
        }
        return Double(cupsPurchased) * Double(truncating: package.storeProduct.priceDecimalNumber)
    }

    let formatter = FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currencyCode ?? "USD")

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Image(systemName: SFSymbols.coffee)
                    .font(.title2)
                    .foregroundColor(colorScheme == .light ? .blue : Color(red: 97.0/255.0, green: 176.0/255.0, blue: 1.0))
                Text("Coffee fund")
                    .font(.title2).bold()
            }
            HStack {
                Text("Cups purchased")
                    .font(.headline)
                Spacer()
                Text("\(cupsPurchased)")
            }
            HStack {
                Text("Amount spent")
                    .font(.headline)
                Spacer()
                Text(amount, format: formatter)
            }
            Button {
                Purchases.shared.purchase(package: package!) { transaction, customerInfo, error, cancelled in
                    if transaction != nil {
                        cupsPurchased += 1
                    }
                }
            } label: {
                Text("Buy the dev a cup of coffee")
                    .foregroundColor(.primary)
                    .padding(5)
            }.buttonStyle(.bordered)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .shadow(radius: 2))
            Text("This just shows support to Maegan and helps the app continue to be developed in the wee hours of the morning and the evening.")
                .font(.caption2)
                .foregroundColor(.secondary)
        }.row()
            .onAppear {
                Purchases.shared.getOfferings { (offerings, error) in
                    if let packages = offerings?.current?.availablePackages {
                        for package in packages {
                            self.package = package
                        }
                        getAllPurchases()
                    }
                }
            }
    }

    func getAllPurchases() {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            guard let customerInfo = customerInfo else {
                return
            }

            for transaction in customerInfo.nonSubscriptionTransactions {
                print(transaction.productIdentifier)
                if package?.storeProduct.productIdentifier == transaction.productIdentifier {
                    cupsPurchased += 1
                }
            }
        }
    }
}

struct BuyDevCoffeeSection_Previews: PreviewProvider {
    static var previews: some View {
        BuyDevCoffeeSection().preferredColorScheme(.dark).padding()
    }
}
