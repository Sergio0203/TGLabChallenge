// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
// swift-tools-version: 5.9
let package = Package(
    name: "NBAService",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NBAService",
            targets: ["NBAService"]
        ),
    ],
    dependencies: [.package(path:"../Client")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NBAService",
            dependencies: [.product(name: "Client", package: "Client")]
        ),
        .testTarget(
            name: "NBAServiceTests",
            dependencies: ["NBAService"]
        ),
    ]
)
