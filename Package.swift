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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.2.0/VCore.xcframework.zip",
            checksum: "a50a48b69c11e658cc8a197f7ee557f98a5153216928d294fc41c118c76971e2"
        ),
    ]
)
