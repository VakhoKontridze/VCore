//
//  MemberwiseInitializableMacroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 22.05.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

nonisolated final class MemberwiseInitializableMacroTests: XCTestCase {
    // MARK: Properties
    private let macros: [String: Macro.Type] = ["MemberwiseInitializable": MemberwiseInitializableMacro.self]

    // MARK: Tests
    func testSimpleProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            nonisolated struct Model {
                let a1: Int
                var a2: Int
                let b1: Int = 0
                var b2: Int = 0
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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
            nonisolated struct Model {
                var a: Int { 0 }
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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
            nonisolated struct Model {
                lazy var a: Int = 0
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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
            nonisolated struct Model {
                static let a: Int = 0
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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
            nonisolated struct Model {
                let a1: Int?
                let a2: Int? = 0
                var b1: Int?
                var b2: Int? = 0
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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

    func testPropertyWrappersAndFunctionAttributes() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            nonisolated struct Model {
                @PropertyWrapper var a: Int
                @ViewBuilder let b: () -> Void
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    @PropertyWrapper var a: Int
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

        assertMacroExpansion(
            """
            @MemberwiseInitializable
            nonisolated class Model {
                @objc let a: Int
                dynamic let b: Int
            }
            """,
            expandedSource: 
                """
                nonisolated class Model {
                    @objc let a: Int
                    dynamic let b: Int

                    internal init(
                        a: Int,
                        b: Int
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
            nonisolated struct Model {
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
                nonisolated struct Model {
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
    
    func testSameLineProperties() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            nonisolated struct Model {
                var a, b: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    var a, b: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "Only one property declaration is allowed per line", line: 3, column: 5)
            ],
            macros: macros
        )
    }

    func testInvalidPropertyType() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            nonisolated struct Model {
                var a = 10
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    var a = 10
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid property type", line: 3, column: 5)
            ],
            macros: macros
        )
    }

    func testAccessLevelModifierParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable
            public nonisolated struct Model: Sendable {
                public let a: Int
            }
            """,
            expandedSource:
                """
                public nonisolated struct Model: Sendable {
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

        assertMacroExpansion(
            """
            @MemberwiseInitializable(accessLevelModifier: .fileprivate)
            nonisolated struct Model {
                let a: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    let a: Int

                    fileprivate init(
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
            nonisolated struct Model {
                let a: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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
        
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                externalParameterNames: [
                    "b": "?"
                ]
            )
            nonisolated struct Model {
                let a: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    let a: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'externalParameterNames' parameter. 'b' is not a property of the declaration.", line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testParameterDefaultValuesParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                parameterDefaultValues: [
                    "a1": .value(1),
                    "a2": .value(2),
                    "b1": .value(3),
                    "b2": .value(4),
                    "c": .value("")
                ]
            )
            nonisolated struct Model {
                let a1: Int
                var a2: Int
                
                let b1: Int?
                var b2: Int?

                let c: String
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    let a1: Int
                    var a2: Int
                    
                    let b1: Int?
                    var b2: Int?

                    let c: String

                    internal init(
                        a1: Int = 1,
                        a2: Int = 2,
                        b1: Int? = 3,
                        b2: Int? = 4,
                        c: String = ""
                    ) {
                        self.a1 = a1
                        self.a2 = a2
                        self.b1 = b1
                        self.b2 = b2
                        self.c = c
                    }
                }
                """,
            macros: macros
        )

        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                parameterDefaultValues: [
                    "b": .omit,
                    "d": .omit,
                ]
            )
            nonisolated struct Model {
                var a: Int?
                var b: Int?
                var c: Int? = 1
                var d: Int? = 1
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    var a: Int?
                    var b: Int?
                    var c: Int? = 1
                    var d: Int? = 1

                    internal init(
                        a: Int? = nil,
                        b: Int?,
                        c: Int? = nil,
                        d: Int?
                    ) {
                        self.a = a
                        self.b = b
                        self.c = c
                        self.d = d
                    }
                }
                """,
            macros: macros
        )
        
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                parameterDefaultValues: [
                    "b": .omit
                ]
            )
            nonisolated struct Model {
                let a: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    let a: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'parameterDefaultValues' parameter. 'b' is not a property of the declaration.", line: 1, column: 1)
            ],
            macros: macros
        )
    }
    
    func testParameterDefaultValuesParameter_WildCard() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                parameterDefaultValues: [
                    "*": .omit
                ]
            )
            nonisolated struct Model {
                var a: Int?
                var b: Int? = 0
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    var a: Int?
                    var b: Int? = 0

                    internal init(
                        a: Int?,
                        b: Int?
                    ) {
                        self.a = a
                        self.b = b
                    }
                }
                """,
            macros: macros
        )
        
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                parameterDefaultValues: [
                    "*": .value(0)
                ]
            )
            nonisolated struct Model {
                var a: Int?
                var b: Int? = 0
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    var a: Int?
                    var b: Int? = 0
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "'0' can not be used as a wildcard value", line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testExcludedParametersParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                excludedParameters: ["b"]
            )
            nonisolated struct Model {
                var a: Int = 1
                var b: Int = 1
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
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
        
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                excludedParameters: ["b"]
            )
            nonisolated struct Model {
                let a: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    let a: Int
                }
                """,
            diagnostics: [
                DiagnosticSpec(message: "Invalid 'excludedParameters' parameter. 'b' is not a property of the declaration.", line: 1, column: 1)
            ],
            macros: macros
        )
    }

    func testCommentParameter() {
        assertMacroExpansion(
            """
            @MemberwiseInitializable(
                comment: "///Lorem ipsum dolor ist amet."
            )
            nonisolated struct Model {
                let a: Int
            }
            """,
            expandedSource:
                """
                nonisolated struct Model {
                    let a: Int

                    ///Lorem ipsum dolor ist amet.
                    internal init(
                        a: Int
                    ) {
                        self.a = a
                    }
                }
                """,
            macros: macros
        )

        assertMacroExpansion(
            #"""
            @MemberwiseInitializable(
                comment: """
                    /// Lorem ipsum dolor ist amet.
                    ///
                    ///     Example.
                    ///
                    """
            )
            nonisolated struct Model {
                let a: Int
            }
            """#,
            expandedSource:
                """
                nonisolated struct Model {
                    let a: Int

                    /// Lorem ipsum dolor ist amet.
                    ///
                    ///     Example.
                    ///
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
            nonisolated enum Model {}
            """,
            expandedSource:
                """
                nonisolated enum Model {}
                """,
            diagnostics: [
                DiagnosticSpec(message: "'MemberwiseInitializable' macro cannot be applied to 'enum's", line: 1, column: 1)
            ],
            macros: macros
        )
    }
}

#endif
