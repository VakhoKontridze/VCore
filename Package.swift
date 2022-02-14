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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.2.1/VCore.xcframework.zip",
            checksum: "d8ddd4b4d0497b1dcf999a1a273cf905536e59b0164a3e26874fdd851bf72242"
        ),
    ]
)
