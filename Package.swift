// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package: Package = .init(
    name: "VCore",

    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],

    products: [
        .library(
            name: "VCore",
            targets: [
                "VCore"
            ]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.1.0")
    ],

    targets: [
        .target(
            name: "VCoreShared"
        ),

        .macro(
            name: "VCoreMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "VCoreShared"
            ]
        ),

        .target(
            name: "VCore",
            dependencies: [
                "VCoreShared",
                "VCoreMacros"
            ],
            exclude: [
                "../../Documentation",
                "../../Extra"
            ]
        ),
        .testTarget(
            name: "VCoreTests",
            dependencies: [
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "VCore",
                "VCoreShared",
                "VCoreMacros"
            ]
        )
    ]
)
