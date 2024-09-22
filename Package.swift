// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "ChatLayout",
    platforms: [
        .iOS(.v12), .macOS(.v11), .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "ChatLayout",
            targets: ["ChatLayout"]
        ),
        .library(name: "ChatLayoutStatic",
                 type: .static,
                 targets: ["ChatLayout"]),
        .library(name: "ChatLayoutDynamic",
                 type: .dynamic,
                 targets: ["ChatLayout"])
    ],
    targets: [
        .target(
            name: "ChatLayout",
            dependencies: [],
            path: "ChatLayout/Classes"
        ),
        .testTarget(
            name: "ChatLayoutTests",
            dependencies: ["ChatLayout"],
            path: "Example/Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
