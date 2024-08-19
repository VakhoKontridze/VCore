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

// MARK: - Tests
final class CodingKeysGenerationMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["CodingKeysGeneration": CodingKeysGenerationMacro.self]

    // MARK: Tests
    func testSimpleDeclaration() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {
                @CKGProperty("one") let one: Int
                @CKGProperty("two") let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct: Encodable {
                    @CKGProperty("one") let one: Int
                    @CKGProperty("two") let two: String

                    internal enum CodingKeys: String, CodingKey {
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
            public struct SomeStruct: Encodable {
                @CKGProperty("one") public let one: Int
                @CKGProperty("two") public let two: String
            }
            """,
            expandedSource: 
                """
                public struct SomeStruct: Encodable {
                    @CKGProperty("one") public let one: Int
                    @CKGProperty("two") public let two: String

                    public enum CodingKeys: String, CodingKey {
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
            struct SomeStruct: Encodable {
                @CKGProperty("one") let one: Int
                @CKGProperty("two") let two: String
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    @CKGProperty("one") let one: Int
                    @CKGProperty("two") let two: String

                    private enum CodingKeys: String, CodingKey {
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
            struct SomeStruct: Encodable {
                @CKGProperty("one") let one: Int
                var two: Int { one * 2 }
                
                var attributes: [String: Any?] = [:]

                func foo() {}
            }
            """,
            expandedSource: 
                """
                struct SomeStruct: Encodable {
                    @CKGProperty("one") let one: Int
                    var two: Int { one * 2 }
                    
                    var attributes: [String: Any?] = [:]

                    func foo() {}

                    internal enum CodingKeys: String, CodingKey {
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
            struct SomeStruct: Encodable {
                @CKGProperty("one") func one() {}
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    @CKGProperty("one") func one() {}
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: CodingKeysGenerationMacroError.canOnlyBeAppliedToVariables.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testSameLineProperties() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {
                @CKGProperty("one+two") let one, two: Int
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    @CKGProperty("one+two") let one, two: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: CodingKeysGenerationMacroError.onePropertyAllowedPerLine.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testNoProperties() {
        assertMacroExpansion( // Compiler will handle errors
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {}
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {

                    internal enum CodingKeys: String, CodingKey {
                    }}
                """,
            macros: macros
        )

        assertMacroExpansion( // Compiler will handle errors
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {
                let one: Int
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    let one: Int

                    internal enum CodingKeys: String, CodingKey {
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
            struct SomeStruct: Encodable {
                @CKGProperty("one") var one: Int { 0 }
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    @CKGProperty("one") var one: Int { 0 }
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: CodingKeysGenerationMacroError.cannotBeAppliedToComputedProperties.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }
}

#endif
