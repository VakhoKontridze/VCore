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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.0.3/VCore.xcframework.zip",
            checksum: "019475499606604bbd23ad376acb8c35dbbccb579d5ae692bad171805b7ba1c3"
        ),
    ]
)
