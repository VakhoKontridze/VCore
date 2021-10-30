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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.1.0/VCore.xcframework.zip",
            checksum: "8623169dc63ddf4ac6e1b19f5001abd0e28a82fc7cfba4cd76c7152a1158df78"
        ),
    ]
)
