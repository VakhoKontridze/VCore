//
//  ColorMacroTests_InitWithHexString.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.01.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

// MARK: - Tests
final class ColorMacroTests_InitWithHexString: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["color": ColorMacro_InitWithHexString.self]

    // MARK: Tests
    func testValid() {
        assertMacroExpansion(
            """
            let color: Color = #color(hex: "#007AFF")
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
            let color: Color = #color(.sRGBLinear, hex: "#007AFF")
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

    func testHexParameter() {
        assertMacroExpansion(
            """
            let color: Color = #color(hex: "#000000007AFF")
            """,
            expandedSource:
                """
                let color: Color = #color(hex: "#000000007AFF")
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'hex' parameter", line: 1, column: 20)
            ],
            macros: macros
        )
    }
}

#endif
