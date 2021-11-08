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
            checksum: "60949bdc10b8877a17b3be53cc74f0e228b628145d4e052699d26fc7cfb39d02"
        ),
    ]
)
