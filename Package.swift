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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.3.0/VCore.xcframework.zip",
            checksum: "999bcf23945b68cfb4b2df47e28cdccdac70c8c5a59d7d0f5d5d47302c3b0880"
        ),
    ]
)
