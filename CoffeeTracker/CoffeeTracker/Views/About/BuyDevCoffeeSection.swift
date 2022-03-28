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
                    .font(.largeTitle)
                    .foregroundColor(colorScheme == .light ? .blue : Color(red: 97.0/255.0, green: 176.0/255.0, blue: 1.0))
                Text("Support future development with a cup of coffee")
                    .font(.title3)
            }.padding(.trailing)
            Text("If you're enjoying coffee_ and want to buy a cup of coffee for the developer, then it is definitely appreciated. The app is free to use, so any additional contributions are always welcome. ")
                .foregroundColor(.secondary)
            Button {
                Purchases.shared.purchase(package: package!) { transaction, customerInfo, error, cancelled in
                    if transaction != nil {
                        cupsPurchased += 1
                    }
                }
            } label: {
                Text("Buy the dev a cup of coffee")
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            Text("Coffee is \(getPackagePrice(package)) a cup")
                .font(.caption2)
                .foregroundColor(.secondary)

            HStack {
                Text("Cups purchased")
                    .font(.headline)
                Spacer()
                Text("\(cupsPurchased)")
            }
            HStack {
                Text("Amount")
                    .font(.headline)
                Spacer()
                Text(amount, format: formatter)
            }

            Group {
                Text("The amount should automatically update and keep updated with each launch of the app.")
                    .font(.caption2)
            }.foregroundColor(.secondary)
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

    func getPackagePrice(_ package: Package?) -> String {
        guard let package = package else {
            return "price not available"
        }

        return package.localizedPriceString
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
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
        BuyDevCoffeeSection().preferredColorScheme(.dark).padding()
        }.preferredColorScheme(.dark)
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
        BuyDevCoffeeSection().preferredColorScheme(.dark).padding()
        }.preferredColorScheme(.light)
    }
}
