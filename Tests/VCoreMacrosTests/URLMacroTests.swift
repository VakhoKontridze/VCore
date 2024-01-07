//
//  URLMacroTests.swift
//  VCoreMacrosTests
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

// MARK: - Tests
final class URLMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["URL": URLMacro.self]

    // MARK: Tests
    func testStringLiteralRequired() {
        assertMacroExpansion(
            #"""
            let urlString: String = "https://example.com"
            let url: URL = #URL(urlString)
            """#,
            expandedSource: #"""
                let urlString: String = "https://example.com"
                let url: URL = #URL(urlString)
                """#
            ,
            diagnostics: [
                DiagnosticSpec(message: URLMacroError.stringLiteralRequired.description, line: 2, column: 16)
            ],
            macros: macros
        )
    }

    func testMalformedURL() {
        assertMacroExpansion(
            #"""
            let url: URL = #URL("https://example .com")
            """#,
            expandedSource: #"""
                let url: URL = #URL("https://example .com")
                """#
            ,
            diagnostics: [
                DiagnosticSpec(message: URLMacroError.malformedURL.description, line: 1, column: 16)
            ],
            macros: macros
        )
    }

    func testValid() {
        assertMacroExpansion(
            #"""
            let url: URL = #URL("https://example.com")
            """#,
            expandedSource: #"""
                let url: URL = URL(string: "https://example.com")!
                """#
            ,
            macros: macros
        )
    }
}
