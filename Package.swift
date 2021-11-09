// swift-tools-version:5.3

import PackageDescription

let package: Package = .init(
    name: "VCore",
    
    platforms: [
        .iOS(.v14)
    ],
    
    products: [
        .library(
            name: "VCore",
            targets: ["VCore"]
        )
    ],
    
    targets: [
        .binaryTarget(
            name: "VCore",
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.4.0/VCore.xcframework.zip",
            checksum: "576bb3856b68921cbeca86aeb8d514f5f227ded1bb8d04eb3a37dfc01dc825e7"
        ),
    ]
)
