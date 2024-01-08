//
//  OptionSetRepresentationMacroTests.swift
//  VCoreTests
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
final class OptionSetRepresentationMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["OptionSetRepresentation": OptionSetRepresentationMacro.self]

    // MARK: Tests
    func testSimpleStruct() {
        assertMacroExpansion(
            """
            @OptionSetRepresentation<UInt8>
            struct Gender {
                private enum Options: Int {
                    case male
                    case female
                }

                static let all: Self = [.male, .female]
            }
            """,
            expandedSource: 
                """
                struct Gender {
                    private enum Options: Int {
                        case male
                        case female
                    }

                    static let all: Self = [.male, .female]

                    internal typealias RawValue = UInt8

                    internal let rawValue: RawValue

                    internal init() {
                        self.rawValue = 0
                    }

                    internal init(rawValue: RawValue) {
                        self.rawValue = rawValue
                    }

                    internal static let male: Self = .init(rawValue: 1 << Options.male.rawValue)

                    internal static let female: Self = .init(rawValue: 1 << Options.female.rawValue)
                }

                extension Gender: OptionSet {
                }
                """
            ,
            macros: macros
        )
    }

    func testNonStruct() {
        assertMacroExpansion(
            """
            @OptionSetRepresentation<UInt8>
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
                }
                """
            ,
            diagnostics: [
                DiagnosticSpec(message: OptionSetRepresentationMacroError.canOnlyBeAppliedToStructs.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testAccessLevelModifier() {
        assertMacroExpansion(
            """
            @OptionSetRepresentation<UInt8>(accessLevelModifier: "public")
            public struct Gender {
                private enum Options: Int {
                    case male
                    case female
                }
            }
            """,
            expandedSource: 
                """
                public struct Gender {
                    private enum Options: Int {
                        case male
                        case female
                    }

                    public typealias RawValue = UInt8

                    public let rawValue: RawValue

                    public init() {
                        self.rawValue = 0
                    }

                    public init(rawValue: RawValue) {
                        self.rawValue = rawValue
                    }

                    public static let male: Self = .init(rawValue: 1 << Options.male.rawValue)

                    public static let female: Self = .init(rawValue: 1 << Options.female.rawValue)
                }

                extension Gender: OptionSet {
                }
                """
            ,
            macros: macros
        )
    }

    func testEmptyStruct() {
        assertMacroExpansion(
            """
            @OptionSetRepresentation<UInt8>
            struct Gender {}
            """,
            expandedSource: 
                """
                struct Gender {}
                """
            ,
            diagnostics: [
                DiagnosticSpec(message: OptionSetRepresentationMacroError.optionsEnumNotFound.description,line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testNoRawType() {
        assertMacroExpansion(
            """
            @OptionSetRepresentation
            struct Gender {
                private enum Options: Int {
                    case male
                    case female
                }
            }
            """
            ,
            expandedSource:
                """
                struct Gender {
                    private enum Options: Int {
                        case male
                        case female
                    }
                }
                """
            ,
            diagnostics: [
                DiagnosticSpec(message: OptionSetRepresentationMacroError.optionsEnumRawTypeNotDeclared.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testAlreadyConformsToOptionSet() {
        assertMacroExpansion(
            """
            @OptionSetRepresentation<UInt8>
            struct Gender: OptionSet {
                private enum Options: Int {
                    case male
                    case female
                }
            }
            """,
            expandedSource: 
                """
                struct Gender: OptionSet {
                    private enum Options: Int {
                        case male
                        case female
                    }

                    internal typealias RawValue = UInt8

                    internal let rawValue: RawValue

                    internal init() {
                        self.rawValue = 0
                    }

                    internal init(rawValue: RawValue) {
                        self.rawValue = rawValue
                    }

                    internal static let male: Self = .init(rawValue: 1 << Options.male.rawValue)

                    internal static let female: Self = .init(rawValue: 1 << Options.female.rawValue)
                }
                """
            ,
            macros: macros
        )
    }
}

#endif
