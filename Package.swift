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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/2.0.1/VCore.xcframework.zip",
            checksum: "cba56103915cafdfa6e9a8a151243ad1a10d74f04a4295784675ce325ecfc97d"
        ),
    ]
)
