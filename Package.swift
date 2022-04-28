// swift-tools-version:5.3

import PackageDescription

let package: Package = .init(
    name: "VCore",
    
    platforms: [
        .iOS(.v13)
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
        ),
    ]
)
