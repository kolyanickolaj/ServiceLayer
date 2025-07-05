// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServiceLayer",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "ServiceLayer",
            targets: ["ServiceLayer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "ServiceLayer",
            dependencies: [
                .product(name: "SwiftyJSON", package: "SwiftyJSON")
            ],
            resources: [
                .process("DB.xcdatamodeld")
            ]
        ),
        .testTarget(
            name: "ServiceLayerTests",
            dependencies: ["ServiceLayer"]
        ),
    ],
    swiftLanguageModes: [.v5]
)
