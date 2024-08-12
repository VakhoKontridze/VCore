// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let package: Package = .init(
    name: "VCore",

    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
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
        .package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.0")
    ],

    targets: [
        .target(
            name: "VCoreShared"
        ),

        .macro(
            name: "VCoreMacrosImplementation",
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
                "VCoreMacrosImplementation"
            ],
            exclude: [
                "../../Documentation",
                "../../Extra"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "VCoreTests",
            dependencies: [
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "VCore",
                "VCoreShared",
                "VCoreMacrosImplementation"
            ]
        )
    ]
)
