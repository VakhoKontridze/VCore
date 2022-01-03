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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.1.1/VCore.xcframework.zip",
            checksum: "f599602ffa6e191b66ac70e4824f26c942ce0c0ff0ad688cd9c65a109c746841"
        ),
    ]
)
