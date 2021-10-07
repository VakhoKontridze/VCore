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
            url: "https://github.com/VakhoKontridze/VCore/releases/download/1.0.1/VCore.xcframework.zip",
            checksum: "b08ee6e4a8223893d6ca31e189770e50bbdb4e63674d4c5799ccbd732f8eb463"
        ),
    ]
)
