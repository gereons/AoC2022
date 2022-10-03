// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // .package(url: "https://github.com/apple/swift-algorithms", from: "0.0.2")
        .package(url: "https://github.com/gereons/AoCTools", from: "0.0.5")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "AdventOfCode",
            dependencies: [
                // .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "AoCTools", package: "AoCTools")
            ],
            path: "Sources"),
        .testTarget(
            name: "aocTests",
            dependencies: [ "AdventOfCode" ],
            path: "Tests")
    ]
)
