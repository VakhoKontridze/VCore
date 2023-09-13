// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = .init(
    name: "VCore",
    
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    
    products: [
        .library(
            name: "VCore",
            targets: ["VCore"]
        )
    ],
    
    targets: [
        .target(
            name: "VCore",
            dependencies: [],
            exclude: [
                "../../Documentation",
                "../../Extra"
            ]
        ),
        .testTarget(
            name: "VCoreTests",
            dependencies: ["VCore"]
        )
    ]
)
