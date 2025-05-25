// swift-tools-version: 6.1
// FIXME: Replace with 6.2
import PackageDescription
import CompilerPluginSupport

let package: Package = .init(
    name: "VCore",

    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
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
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "601.0.0")
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
