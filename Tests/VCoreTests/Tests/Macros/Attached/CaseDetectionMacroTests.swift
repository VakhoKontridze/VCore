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
    func testSimpleEnum() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum Gender {
                case male
                case female
            }
            """,
            expandedSource: 
                """
                enum Gender {
                    case male
                    case female

                    internal var isMale: Bool {
                        if case .male = self {
                            true
                        } else {
                            false
                        }
                    }

                    internal var isFemale: Bool {
                        if case .female = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """,
            macros: macros
        )
    }

    func testEmptyEnum() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum Gender {}
            """,
            expandedSource: 
                """
                enum Gender {}
                """,
            macros: macros
        )
    }

    func testNonEnum() {
        assertMacroExpansion(
            """
            @CaseDetection
            struct SomeStruct {}
            """,
            expandedSource: 
                """
                struct SomeStruct {}
                """,
            diagnostics: [
                DiagnosticSpec(message: CaseDetectionMacroError.canOnlyBeAppliedToEnums.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testAccessLevelModifierParameter() {
        assertMacroExpansion(
            """
            @CaseDetection(accessLevelModifier: "fileprivate")
            enum Gender {
                case male
                case female
            }
            """,
            expandedSource: 
                """
                enum Gender {
                    case male
                    case female

                    fileprivate var isMale: Bool {
                        if case .male = self {
                            true
                        } else {
                            false
                        }
                    }

                    fileprivate var isFemale: Bool {
                        if case .female = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """,
            macros: macros
        )
    }

    func testCaseNamesWithBackticks() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum Result {
                case `false`
            }
            """,
            expandedSource: 
                """
                enum Result {
                    case `false`

                    internal var isFalse: Bool {
                        if case .false = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """,
            macros: macros
        )
    }

    func testAssociatedValues() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum PointPixelMeasurement {
                case points(displayScale: Int)
                case pixels
            }
            """,
            expandedSource: 
                """
                enum PointPixelMeasurement {
                    case points(displayScale: Int)
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
                """,
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
                """,
            macros: macros
        )
    }

    func testSameLineCases() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum Gender {
                case male, female
            }
            """,
            expandedSource:
                """
                enum Gender {
                    case male, female

                    internal var isMale: Bool {
                        if case .male = self {
                            true
                        } else {
                            false
                        }
                    }

                    internal var isFemale: Bool {
                        if case .female = self {
                            true
                        } else {
                            false
                        }
                    }
                }
                """,
            macros: macros
        )
    }
}

#endif
