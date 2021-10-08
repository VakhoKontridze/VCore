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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.0.2/VCore.xcframework.zip",
            checksum: "58e3a4752d7cfccb37bca09923857e847d5aba208cd3421575fb8dc48408b9de"
        ),
    ]
)
