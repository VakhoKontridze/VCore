// swift-tools-version: 6.2

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
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0")
    ],

    targets: [
        .target(
            name: "VCoreShared",
            swiftSettings: [
                .defaultIsolation(MainActor.self),
                .enableUpcomingFeature("ApproachableConcurrency"),
                .enableUpcomingFeature("NonIsolatedNonSendingByDefault")
            ]
        ),

        .macro(
            name: "VCoreMacrosImplementation",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "VCoreShared"
            ],
            swiftSettings: [
                .defaultIsolation(MainActor.self),
                .enableUpcomingFeature("ApproachableConcurrency"),
                .enableUpcomingFeature("NonIsolatedNonSendingByDefault")
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
                .process("PrivacyInfo.xcprivacy")
            ],
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
        .testTarget(
            name: "VCoreTests",
            dependencies: [
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "VCore",
                "VCoreShared",
                "VCoreMacrosImplementation"
            ],
            swiftSettings: [
                .defaultIsolation(MainActor.self),
                .enableUpcomingFeature("ApproachableConcurrency"),
                .enableUpcomingFeature("NonIsolatedNonSendingByDefault")
            ]
        )
    ]
)
