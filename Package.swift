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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.0.0/VCore.xcframework.zip",
            checksum: "7a11d0d3f628a6fb9fccc5446f152dc749534d1988a197a3f4118be3f978ef8b"
        ),
    ]
)
