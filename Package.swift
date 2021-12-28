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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.0.0/VCore.xcframework.zip",
            checksum: "58e0c906b67c3f35c92f70b0038f4364d184dd0fda146a386cd7886852e546c4"
        ),
    ]
)
