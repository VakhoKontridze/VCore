//
//  URLMacroTests_InitWithString.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

// MARK: - Tests
final class URLMacroTests_InitWithString: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["url": URLMacro_InitWithString.self]

    // MARK: Tests
    func testValid() {
        assertMacroExpansion(
            """
            let url: URL = #url("https://example.com")
            """,
            expandedSource:
                """
                let url: URL = URL(string: "https://example.com")!
                """,
            macros: macros
        )
    }

    func testStringURLParameter() {
        assertMacroExpansion(
            """
            let urlString: String = "https://example.com"
            let url: URL = #url(urlString)
            """,
            expandedSource: 
                """
                let urlString: String = "https://example.com"
                let url: URL = #url(urlString)
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'urlString' parameter", line: 2, column: 16)
            ],
            macros: macros
        )

        assertMacroExpansion(
            """
            let url: URL = #url("https://example .com")
            """,
            expandedSource: 
                """
                let url: URL = #url("https://example .com")
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'urlString' parameter", line: 1, column: 16)
            ],
            macros: macros
        )
    }
}

#endif
