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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.0.2/VCore.xcframework.zip",
            checksum: "7b4733415a41f2d4b6ecb827b68b275ceaad2d1451ad0927093013691f6d1491"
        ),
    ]
)
