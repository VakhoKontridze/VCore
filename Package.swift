// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let swiftSettings: [SwiftSetting] = [
    .unsafeFlags([
        "-Xfrontend", "-debug-time-function-bodies",
        "-Xfrontend", "-debug-time-expression-type-checking",
        "-Xfrontend", "-warn-long-function-bodies=100",
        "-Xfrontend", "-warn-long-expression-type-checking=100"
    ])
]

let package: Package = .init(
    name: "VCore",

    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
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
        .package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.0") // FIXME: Update
    ],

    targets: [
        .target(
            name: "VCoreShared",
            swiftSettings: swiftSettings
        ),

        .macro(
            name: "VCoreMacrosImplementation",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "VCoreShared"
            ],
            swiftSettings: swiftSettings
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
            swiftSettings: swiftSettings
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
