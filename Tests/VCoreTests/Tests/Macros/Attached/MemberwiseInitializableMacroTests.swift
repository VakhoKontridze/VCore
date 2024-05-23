//
//  MemberwiseInitializableMacroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 22.05.24.
//

#if canImport(VCoreMacros)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacros

// MARK: - Tests
final class MemberwiseInitializableMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["MemberwiseInitializable": MemberwiseInitializableMacro.self]

    // MARK: Tests
    func testSimpleProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                let a1: Int
                var a2: Int
                let b1: Int = 0
                var b2: Int = 0
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    let a1: Int
                    var a2: Int
                    let b1: Int = 0
                    var b2: Int = 0

                    internal init(
                        a1: Int,
                        a2: Int,
                        b2: Int
                    ) {
                        self.a1 = a1
                        self.a2 = a2
                        self.b2 = b2
                    }
                }
                """,
            macros: macros
        )
    }

    func testComputedProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                var a: Int { 0 }
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    var a: Int { 0 }

                    internal init(
                    ) {
                    }
                }
                """,
            macros: macros
        )
    }

    func testLazyProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                lazy var a: Int = 0
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    lazy var a: Int = 0

                    internal init(
                    ) {
                    }
                }
                """,
            macros: macros
        )
    }

    func testStaticProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                static let a: Int = 0
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    static let a: Int = 0

                    internal init(
                    ) {
                    }
                }
                """,
            macros: macros
        )
    }

    func testOptionalProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                let a1: Int?
                let a2: Int? = 0
                var b1: Int?
                var b2: Int? = 0
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    let a1: Int?
                    let a2: Int? = 0
                    var b1: Int?
                    var b2: Int? = 0

                    internal init(
                        a1: Int?,
                        b1: Int? = nil,
                        b2: Int? = nil
                    ) {
                        self.a1 = a1
                        self.b1 = b1
                        self.b2 = b2
                    }
                }
                """,
            macros: macros
        )
    }

    func testPropertyWrappersAndFunctionAttributed() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                @SomeWrapper var a: Int
                @ViewBuilder let b: () -> Void
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    @SomeWrapper var a: Int
                    @ViewBuilder let b: () -> Void

                    internal init(
                        a: Int,
                        @ViewBuilder b: @escaping () -> Void
                    ) {
                        self.a = a
                        self.b = b
                    }
                }
                """,
            macros: macros
        )
    }

    func testClosures() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                let a1: () -> Void
                let a2: (() -> Void)?

                let b1: () -> (() -> Void)
                let b2: () -> (() -> Void)?
                let b3: (() -> (() -> Void))?
                let b4: (() -> (() -> Void)?)?

                let c1: (() -> Void) -> Void
                let c2: ((() -> Void)?) -> Void
                let c3: ((() -> Void) -> Void)?
                let c4: (((() -> Void)?) -> Void)?

                let d: () async throws -> Void

                let e: @Sendable () -> Void
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    let a1: () -> Void
                    let a2: (() -> Void)?

                    let b1: () -> (() -> Void)
                    let b2: () -> (() -> Void)?
                    let b3: (() -> (() -> Void))?
                    let b4: (() -> (() -> Void)?)?

                    let c1: (() -> Void) -> Void
                    let c2: ((() -> Void)?) -> Void
                    let c3: ((() -> Void) -> Void)?
                    let c4: (((() -> Void)?) -> Void)?

                    let d: () async throws -> Void

                    let e: @Sendable () -> Void

                    internal init(
                        a1: @escaping () -> Void,
                        a2: (() -> Void)?,
                        b1: @escaping () -> (() -> Void),
                        b2: @escaping () -> (() -> Void)?,
                        b3: (() -> (() -> Void))?,
                        b4: (() -> (() -> Void)?)?,
                        c1: @escaping (() -> Void) -> Void,
                        c2: @escaping ((() -> Void)?) -> Void,
                        c3: ((() -> Void) -> Void)?,
                        c4: (((() -> Void)?) -> Void)?,
                        d: @escaping () async throws -> Void,
                        e: @escaping @Sendable () -> Void
                    ) {
                        self.a1 = a1
                        self.a2 = a2
                        self.b1 = b1
                        self.b2 = b2
                        self.b3 = b3
                        self.b4 = b4
                        self.c1 = c1
                        self.c2 = c2
                        self.c3 = c3
                        self.c4 = c4
                        self.d = d
                        self.e = e
                    }
                }
                """,
            macros: macros
        )
    }

    func testInvalidPropertyType() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                var a = 10
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    var a = 10
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: MemberwiseInitializableMacroError.invalidPropertyType.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testSameLineProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            struct SomeStruct {
                var a, b: Int
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    var a, b: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: MemberwiseInitializableMacroError.onePropertyAllowedPerLine.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testAccessLevelModifierParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(accessLevelModifier: .public)
            public struct SomeStruct {
                public let a: Int
            }
            """,
            expandedSource:
                """
                public struct SomeStruct {
                    public let a: Int

                    public init(
                        a: Int
                    ) {
                        self.a = a
                    }
                }
                """,
            macros: macros
        )
    }

    func testExternalParameterNameParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                externalParameterNames: [
                    "a": "_"
                ]
            )
            struct SomeStruct {
                let a: Int
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    let a: Int

                    internal init(
                        _ a: Int
                    ) {
                        self.a = a
                    }
                }
                """,
            macros: macros
        )
    }

    func testParameterDefaultValuesParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                parameterDefaultValues: [
                    "a1": "1",
                    "a2": "2",
                    "b1": "3",
                    "b2": "4",
                ]
            )
            struct SomeStruct {
                let a1: Int
                var a2: Int
                let b1: Int?
                var b2: Int?
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    let a1: Int
                    var a2: Int
                    let b1: Int?
                    var b2: Int?

                    internal init(
                        a1: Int = 1,
                        a2: Int = 2,
                        b1: Int? = 3,
                        b2: Int? = 4
                    ) {
                        self.a1 = a1
                        self.a2 = a2
                        self.b1 = b1
                        self.b2 = b2
                    }
                }
                """,
            macros: macros
        )
    }

    func testExcludedParametersParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                excludedParameters: ["b"]
            )
            struct SomeStruct {
                var a: Int = 1
                var b: Int = 1
            }
            """,
            expandedSource:
                """
                struct SomeStruct {
                    var a: Int = 1
                    var b: Int = 1

                    internal init(
                        a: Int
                    ) {
                        self.a = a
                    }
                }
                """,
            macros: macros
        )
    }

    func testEnum() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            enum SomeEnum {}
            """,
            expandedSource:
                """
                enum SomeEnum {}
                """,
            diagnostics: [
                DiagnosticSpec(message: MemberwiseInitializableMacroError.cannotBeAppliedToEnums.description, line: 1, column: 1)
            ],
            macros: macros
        )
    }
}

#endif
