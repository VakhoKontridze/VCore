//
//  EnvironmentValueGenerationMacroTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 19.04.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

// MARK: - Tests
final class EnvironmentValueGenerationMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["EnvironmentValueGeneration": EnvironmentValueGenerationMacro.self]

    // MARK: Tests
    func testSimpleProperty() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration var value: Int = 10
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    var value: Int {
                        get {
                            self [value_EnvironmentKey.self]
                        }
                        set {
                            self [value_EnvironmentKey.self] = newValue
                        }
                    }

                    private struct value_EnvironmentKey: EnvironmentKey {
                        static let defaultValue: Int = 10
                    }
                }
                """,
            macros: macros
        )
    }

    func testOptionalProperty() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration var value: Int? = 10
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    var value: Int? {
                        get {
                            self [value_EnvironmentKey.self]
                        }
                        set {
                            self [value_EnvironmentKey.self] = newValue
                        }
                    }

                    private struct value_EnvironmentKey: EnvironmentKey {
                        static let defaultValue: Int? = 10
                    }
                }
                """,
            macros: macros
        )
    }

    func testOptionalPropertyWithoutDefaultValue() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration var value: Int?
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    var value: Int? {
                        get {
                            self [value_EnvironmentKey.self]
                        }
                        set {
                            self [value_EnvironmentKey.self] = newValue
                        }
                    }

                    private struct value_EnvironmentKey: EnvironmentKey {
                        static let defaultValue: Int?
                    }
                }
                """,
            macros: macros
        )
    }

    func testNonProperty() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration
                struct SomeStruct {}
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    struct SomeStruct {}
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: EnvironmentValueGenerationMacroError.canOnlyBeAppliedToProperties.description, line: 2, column: 5)
            ],
            macros: macros
        )
    }

    func testConstantProperty() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration let value: Int = 10
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    let value: Int = 10
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: EnvironmentValueGenerationMacroError.canOnlyBeAppliedToVariableProperties.description, line: 2, column: 5)
            ],
            macros: macros
        )
    }

    func testInvalidPropertyType() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration var value = 10
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    var value = 10
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: EnvironmentValueGenerationMacroError.invalidPropertyType.description, line: 2, column: 5)
            ],
            macros: macros
        )
    }

    func testInvalidPropertyDefaultValue() {
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentValueGeneration var value: Int
            }
            """,
            expandedSource:
                """
                extension EnvironmentValues {
                    var value: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: EnvironmentValueGenerationMacroError.invalidDefaultValue.description, line: 2, column: 5)
            ],
            macros: macros
        )
    }
}

#endif
