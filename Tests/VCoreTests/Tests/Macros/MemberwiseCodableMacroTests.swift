//
//  MemberwiseCodableMacroTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if canImport(VCoreMacros)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacros

// MARK: - Tests
final class MemberwiseCodableMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["MemberwiseCodable": MemberwiseCodableMacro.self]

    // MARK: Tests
    func testSimpleDeclaration() {
        assertMacroExpansion(
            """
            @MemberwiseCodable
            struct SomeStruct {
                @MWCKey("key_one") let one: Int
                @MWCKey("key_two") let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct {
                    @MWCKey("key_one") let one: Int
                    @MWCKey("key_two") let two: String

                    internal enum CodingKeys: String, CodingKey {
                        case one = "key_one"
                        case two = "key_two"
                    }
                }
                """
            ,
            macros: macros
        )
    }


    func testDefaultValues() {
        assertMacroExpansion(
            """
            @MemberwiseCodable
            struct SomeStruct {
                let one: Int
                @MWCKey("key_two") let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct {
                    let one: Int
                    @MWCKey("key_two") let two: String

                    internal enum CodingKeys: String, CodingKey {
                        case one
                        case two = "key_two"
                    }
                }
                """
            ,
            macros: macros
        )
    }

    func testAccessLevelModifier() {
        assertMacroExpansion(
            """
            @MemberwiseCodable(accessLevelModifier: "private")
            struct SomeStruct {
                let one: Int
                let two: String
            }
            """,
            expandedSource: 
                """
                struct SomeStruct {
                    let one: Int
                    let two: String

                    private enum CodingKeys: String, CodingKey {
                        case one
                        case two
                    }
                }
                """
            ,
            macros: macros
        )
    }

    func testOtherMembers() {
        assertMacroExpansion(
            """
            @MemberwiseCodable
            struct SomeStruct {
                let one: Int
                let two: String

                func foo() {}
            }
            """,
            expandedSource: 
                """
                struct SomeStruct {
                    let one: Int
                    let two: String

                    func foo() {}

                    internal enum CodingKeys: String, CodingKey {
                        case one
                        case two
                    }
                }
                """
            ,
            macros: macros
        )
    }

    func testSameLineProperties() {
        assertMacroExpansion(
            """
            @MemberwiseCodable
            struct SomeStruct {
                let one, two: Int
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    let one, two: Int
                }
                """
            ,
            diagnostics: [
                DiagnosticSpec(message: MemberwiseCodableMacroError.onePropertyAllowedPerLine.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }
}

#endif

