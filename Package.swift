// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.2")
    ],

    targets: [
        .target(
            name: "VCore",
            dependencies: [
                "VCoreMacros"
            ],
            exclude: [
                "../../Documentation",
                "../../Extra"
            ]
        ),
        .macro(
            name: "VCoreMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .testTarget(
            name: "VCoreTests",
            dependencies: [
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "VCore",
                "VCoreMacros"
            ]
        )
    ]
)
