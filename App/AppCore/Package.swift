// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppCore",
  platforms: [.iOS(.v17)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "AppCore",
      targets: ["AppCore"]
    ),
    .library(
      name: "Models",
      targets: ["Models"]
    ),
    .library(
      name: "Beans",
      targets: ["Beans"]
    ),
    .library(name: "Roasters", targets: ["Roasters"]),
    .library(name: "FirebaseClient", targets: ["FirebaseClient"]),
    .library(name: "Utilities", targets: ["Utilities"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.21.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "AppCore",
      dependencies: ["Beans", "Roasters", "FirebaseClient"]
    ),
    .testTarget(
      name: "AppCoreTests",
      dependencies: ["AppCore"]
    ),
    .target(
      name: "Models"
    ),
    .testTarget(
      name: "ModelsTests",
      dependencies: ["Models"]
    ),
    .target(
      name: "Beans",
      dependencies: ["Models", "Roasters"]
    ),
    .target(
      name: "Roasters",
      dependencies: ["Models"]
    ),
    .target(
      name: "FirebaseClient",
      dependencies: [
        .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
        "Utilities",
      ]
    ),
    .target(name: "Utilities"),
  ]
)
