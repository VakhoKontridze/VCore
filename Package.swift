// swift-tools-version: 5.6

import PackageDescription

let package: Package = .init(
    name: "VCore",
    
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
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
            dependencies: []
        ),
        .testTarget(
            name: "VCoreTests",
            dependencies: ["VCore"]
        )
    ]
)
