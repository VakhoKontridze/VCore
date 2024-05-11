//
//  ColorMacroTests_InitWithHexUInt.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.01.24.
//

// Other test cases are covered under `UIColorInitWithHexTests`

#if canImport(VCoreMacros)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacros

// MARK: - Tests
final class ColorMacroTests_InitWithHexUInt: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["color": ColorMacro_InitWithHexUInt.self]

    // MARK: Tests
    func testValid() {
        assertMacroExpansion(
            """
            let color: Color = #color(hex: 0x007AFF)
            """,
            expandedSource:
                """
                let color: Color = Color(
                    .sRGB,
                    red: 0.0,
                    green: 0.47843137254901963,
                    blue: 1.0,
                    opacity: 1.0
                )
                """,
            macros: macros
        )
    }

    func testColorSpaceParameter() {
        assertMacroExpansion(
            """
            let color: Color = #color(.sRGBLinear, hex: 0x007AFF)
            """,
            expandedSource:
                """
                let color: Color = Color(
                    .sRGBLinear,
                    red: 0.0,
                    green: 0.47843137254901963,
                    blue: 1.0,
                    opacity: 1.0
                )
                """,
            macros: macros
        )
    }

    func testOpacityParameter() {
        assertMacroExpansion(
            """
            let color: Color = #color(hex: 0x007AFF, opacity: 0.5)
            """,
            expandedSource:
                """
                let color: Color = Color(
                    .sRGB,
                    red: 0.0,
                    green: 0.47843137254901963,
                    blue: 1.0,
                    opacity: 0.5
                )
                """,
            macros: macros
        )
    }

    func testManyCharactersInHexParameter() {
        assertMacroExpansion(
            """
            let color: Color = #color(hex: 0x000000007AFF)
            """,
            expandedSource:
                """
                let color: Color = Color(
                    .sRGB,
                    red: 0.0,
                    green: 0.47843137254901963,
                    blue: 1.0,
                    opacity: 1.0
                )
                """,
            macros: macros
        )
    }
}

#endif
