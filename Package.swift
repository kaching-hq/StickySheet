// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StickySheet",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "StickySheet", targets: ["StickySheet"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "StickySheet", dependencies: []),
        .testTarget(name: "StickySheetTests", dependencies: ["StickySheet"]),
    ]
)
