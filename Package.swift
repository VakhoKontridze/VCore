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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.3.0/VCore.xcframework.zip",
            checksum: "a5cef415d0b7db4fc6cba88bf190f95433058a805770a3c3fec07b260b3510c9"
        ),
    ]
)
