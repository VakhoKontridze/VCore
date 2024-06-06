//
//  CodingKeysGenerationMacroTests.swift
//  VCore
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
                @CKGCodingKey("key_one") let one: Int
                @CKGCodingKey("key_two") let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct: Encodable {
                    @CKGCodingKey("key_one") let one: Int
                    @CKGCodingKey("key_two") let two: String

                    internal enum CodingKeys: String, CodingKey {
                        case one = "key_one"
                        case two = "key_two"
                    }
                }
                """,
            macros: macros
        )
    }


    func testNoCustomCodingKey() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {
                let one: Int
                @CKGCodingKey("key_two") let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct: Encodable {
                    let one: Int
                    @CKGCodingKey("key_two") let two: String

                    internal enum CodingKeys: String, CodingKey {
                        case one
                        case two = "key_two"
                    }
                }
                """,
            macros: macros
        )
    }

    func testAccessLevelModifierParameter() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration(accessLevelModifier: .private)
            struct SomeStruct: Encodable {
                let one: Int
                let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct: Encodable {
                    let one: Int
                    let two: String

                    private enum CodingKeys: String, CodingKey {
                        case one
                        case two
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
                let one: Int
                let two: String

                @CKGCodingKeyIgnored var attributes: [String: Any?] = [:]

                func foo() {}
            }
            """,
            expandedSource: 
                """
                struct SomeStruct: Encodable {
                    let one: Int
                    let two: String

                    @CKGCodingKeyIgnored var attributes: [String: Any?] = [:]

                    func foo() {}

                    internal enum CodingKeys: String, CodingKey {
                        case one
                        case two
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
                @CKGCodingKey("one") func one() {}
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    @CKGCodingKey("one") func one() {}
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
                let one, two: Int
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    let one, two: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: CodingKeysGenerationMacroError.onePropertyAllowedPerLine.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testNoProperties() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {}
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {}
                """,
            macros: macros
        )
    }

    func testInvalidProperties() {
        assertMacroExpansion(
            """
            @CodingKeysGeneration
            struct SomeStruct: Encodable {
                @CKGCodingKey("one") var one: Int { 0 }
            }
            """,
            expandedSource:
                """
                struct SomeStruct: Encodable {
                    @CKGCodingKey("one") var one: Int { 0 }
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
