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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.2.0/VCore.xcframework.zip",
            checksum: "7e557333b487512fb93a95c162e3cd05eec16c6e78410db76960b7a683517f62"
        ),
    ]
)
