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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.1.0/VCore.xcframework.zip",
            checksum: "f49316f51f3a453fff6ac3b60584f5e72bdb53a1ad633b98e23a25f1b92e870a"
        ),
    ]
)
