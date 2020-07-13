// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "PainFreeJits",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.3.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc.1"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Leaf", package: "leaf"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver")
        ]),
        .target(name: "Run", dependencies: [
            .target(name: "App"),
        ]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
