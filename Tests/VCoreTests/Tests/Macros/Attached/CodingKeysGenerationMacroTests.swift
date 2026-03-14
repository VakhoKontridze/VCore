//
//  CodingKeysGenerationMacroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

nonisolated final class CodingKeysGenerationMacroTests: XCTestCase {
    // MARK: Properties
    private let macros: [String: Macro.Type] = ["CodingKeysGeneration": CodingKeysGenerationMacro.self]

    // MARK: Tests
    func testSimpleDeclaration() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {
                @CKGProperty("one") let one: Int
                @CKGProperty("two") let two: String
            }
            """,
            expandedSource: 
                """
                nonisolated struct Model: Encodable {
                    @CKGProperty("one") let one: Int
                    @CKGProperty("two") let two: String

                    internal nonisolated enum CodingKeys: String, CodingKey {
                        case one = "one"
                        case two = "two"
                    }
                }
                """,
            macros: macros
        )
    }

    func testAccessLevelModifierParameter() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            public nonisolated struct Model: Sendable, Encodable {
                @CKGProperty("one") public let one: Int
                @CKGProperty("two") public let two: String
            }
            """,
            expandedSource: 
                """
                public nonisolated struct Model: Sendable, Encodable {
                    @CKGProperty("one") public let one: Int
                    @CKGProperty("two") public let two: String

                    public nonisolated enum CodingKeys: String, CodingKey {
                        case one = "one"
                        case two = "two"
                    }
                }
                """,
            macros: macros
        )

        assertMacroExpansion(
            """
            @CodingKeysGeneration(accessLevelModifier: .private)
            nonisolated struct Model: Encodable {
                @CKGProperty("one") let one: Int
                @CKGProperty("two") let two: String
            }
            """,
            expandedSource:
                """
                nonisolated struct Model: Encodable {
                    @CKGProperty("one") let one: Int
                    @CKGProperty("two") let two: String

                    private nonisolated enum CodingKeys: String, CodingKey {
                        case one = "one"
                        case two = "two"
                    }
                }
                """,
            macros: macros
        )
    }

    func testOtherMembers() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {
                @CKGProperty("one") let one: Int
                var two: Int { one * 2 }
                
                var attributes: [String: Any] = [:]

                func foo() {}
            }
            """,
            expandedSource: 
                """
                nonisolated struct Model: Encodable {
                    @CKGProperty("one") let one: Int
                    var two: Int { one * 2 }
                    
                    var attributes: [String: Any] = [:]

                    func foo() {}

                    internal nonisolated enum CodingKeys: String, CodingKey {
                        case one = "one"
                    }
                }
                """,
            macros: macros
        )
    }

    func testNonProperties() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {
                @CKGProperty("one") func one() {}
            }
            """,
            expandedSource:
                """
                nonisolated struct Model: Encodable {
                    @CKGProperty("one") func one() {}
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "'CKGProperty' macro can only be applied to variables", line: 3, column: 5)
            ],
            macros: macros
        )
    }

    func testSameLineProperties() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {
                @CKGProperty("one+two") let one, two: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model: Encodable {
                    @CKGProperty("one+two") let one, two: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "Only one property declaration is allowed per line", line: 3, column: 5)
            ],
            macros: macros
        )
    }

    func testNoProperties() {
        assertMacroExpansion( // Compiler will handle errors
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {}
            """,
            expandedSource:
                """
                nonisolated struct Model: Encodable {

                    internal nonisolated enum CodingKeys: String, CodingKey {
                    }
                }
                """,
            macros: macros
        )

        assertMacroExpansion( // Compiler will handle errors
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {
                let one: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model: Encodable {
                    let one: Int

                    internal nonisolated enum CodingKeys: String, CodingKey {
                    }
                }
                """,
            macros: macros
        )
    }

    func testInvalidProperties() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            nonisolated struct Model: Encodable {
                @CKGProperty("one") var one: Int { 0 }
            }
            """,
            expandedSource:
                """
                nonisolated struct Model: Encodable {
                    @CKGProperty("one") var one: Int { 0 }
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "'CKGProperty' macro can not be applied to computed properties", line: 3, column: 5)
            ],
            macros: macros
        )
    }
}

#endif
