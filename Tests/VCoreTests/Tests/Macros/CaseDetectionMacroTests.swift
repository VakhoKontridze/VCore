//
//  CaseDetectionMacroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

#if canImport(VCoreMacros)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacros

// MARK: - Tests
final class CaseDetectionMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["CaseDetection": CaseDetectionMacro.self]

    // MARK: Tests
    func testSimpleEnumeration() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum SomeEnum {
                case first
            }
            """,
            expandedSource: 
                """
                enum SomeEnum {
                    case first

                    internal var isFirst: Bool {
                        if case .first = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """
            ,
            macros: macros
        )
    }

    func testEmptyEnumeration() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum SomeEnum {}
            """,
            expandedSource: 
                """
                enum SomeEnum {}
                """
            ,
            macros: macros
        )
    }

    func testNonEnumeration() {
        assertMacroExpansion(
            """
            @CaseDetection
            struct SomeStruct {}
            """,
            expandedSource: 
                """
                struct SomeStruct {}
                """
            ,
            diagnostics: [
                DiagnosticSpec(message: CaseDetectionMacroError.canOnlyBeAppliedToEnums.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testAccessLevelModifier() {
        assertMacroExpansion(
            """
            @CaseDetection(accessLevelModifier: "fileprivate")
            enum SomeEnum {
                case first
            }
            """,
            expandedSource: 
                """
                enum SomeEnum {
                    case first

                    fileprivate var isFirst: Bool {
                        if case .first = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """
            ,
            macros: macros
        )
    }

    func testCaseNamesWithBackticks() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum SomeEnum {
                case `false`
            }
            """,
            expandedSource: 
                """
                enum SomeEnum {
                    case `false`

                    internal var isFalse: Bool {
                        if case .false = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """
            ,
            macros: macros
        )
    }

    func testAssociatedValues() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum PointPixelMeasurement {
                case points(displayScale: CGFloat)
                case pixels
            }
            """,
            expandedSource: 
                """
                enum PointPixelMeasurement {
                    case points(displayScale: CGFloat)
                    case pixels

                    internal var isPoints: Bool {
                        if case .points = self {
                            true
                        } else {
                            false
                        }
                    }

                    internal var isPixels: Bool {
                        if case .pixels = self {
                            true
                        } else {
                            false
                        }
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
            @CaseDetection
            enum SomeEnum {
                case first
                var second: Self { first }
            }
            """,
            expandedSource: 
                """
                enum SomeEnum {
                    case first
                    var second: Self { first }

                    internal var isFirst: Bool {
                        if case .first = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """
            ,
            macros: macros
        )
    }
}

#endif
