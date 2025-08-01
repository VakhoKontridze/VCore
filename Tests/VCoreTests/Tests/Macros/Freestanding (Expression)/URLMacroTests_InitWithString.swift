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

final class URLMacroTests_InitWithString: XCTestCase {
    // MARK: Properties
    private let macros: [String: Macro.Type] = ["url": URLMacro_InitWithString.self]

    // MARK: Tests
    func testValid() {
        assertMacroExpansion(
            """
            let url: URL = #url("https://website.com")
            """,
            expandedSource:
                """
                let url: URL = URL(string: "https://website.com")!
                """,
            macros: macros
        )
    }

    func testStringURLParameter() {
        assertMacroExpansion(
            """
            let urlString: String = "https://website.com"
            let url: URL = #url(urlString)
            """,
            expandedSource: 
                """
                let urlString: String = "https://website.com"
                let url: URL = #url(urlString)
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'urlString' parameter", line: 2, column: 16)
            ],
            macros: macros
        )

        assertMacroExpansion(
            """
            let url: URL = #url("https://website .com")
            """,
            expandedSource: 
                """
                let url: URL = #url("https://website .com")
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'urlString' parameter", line: 1, column: 16)
            ],
            macros: macros
        )
    }
}

#endif
