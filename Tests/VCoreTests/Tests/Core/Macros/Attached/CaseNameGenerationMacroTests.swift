//
//  CaseNameGenerationMacroTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28/4/26.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation

nonisolated final class CaseNameGenerationMacroTests: XCTestCase {
    // MARK: Properties
    private let macros: [String: Macro.Type] = ["CaseNameGeneration": CaseNameGenerationMacro.self]
    
    // MARK: Tests
    func testSimpleDeclaration() {
        assertMacroExpansion(
            """
            @CaseNameGeneration
            nonisolated enum Model {
                case a
                case b
            }
            """,
            expandedSource:
                """
                nonisolated enum Model {
                    case a
                    case b
                
                    internal func toName() -> Name {
                        switch self {
                        case .a:
                            .a
                        case .b:
                            .b
                        }
                    }
                
                    internal func `is`(_ name: Name) -> Bool {
                        toName() == name
                    }

                    internal nonisolated enum Name: CaseIterable {
                        case a
                        case b
                    }
                }
                """,
            macros: macros
        )
    }
    
    func testAssociatedValues() {
        assertMacroExpansion(
            """
            @CaseNameGeneration
            nonisolated enum Model {
                case a(Int)
                case b(a: Int, b: String)
            }
            """,
            expandedSource:
                """
                nonisolated enum Model {
                    case a(Int)
                    case b(a: Int, b: String)
                
                    internal func toName() -> Name {
                        switch self {
                        case .a:
                            .a
                        case .b:
                            .b
                        }
                    }
                
                    internal func `is`(_ name: Name) -> Bool {
                        toName() == name
                    }

                    internal nonisolated enum Name: CaseIterable {
                        case a
                        case b
                    }
                }
                """,
            macros: macros
        )
    }
    
    func testAccessLevelModifierParameter() {
        assertMacroExpansion(
            """
            @CaseNameGeneration
            public nonisolated enum Model {
                case a
                case b
            }
            """,
            expandedSource:
                """
                public nonisolated enum Model {
                    case a
                    case b
                
                    public func toName() -> Name {
                        switch self {
                        case .a:
                            .a
                        case .b:
                            .b
                        }
                    }
                
                    public func `is`(_ name: Name) -> Bool {
                        toName() == name
                    }

                    public nonisolated enum Name: CaseIterable {
                        case a
                        case b
                    }
                }
                """,
            macros: macros
        )
    }
    
    func testOtherMembers() {
        assertMacroExpansion(
            """
            @CaseNameGeneration
            nonisolated enum Model {
                case a
                case b
            
                var foo: Int { 0 }
            }
            """,
            expandedSource:
                """
                nonisolated enum Model {
                    case a
                    case b
                
                    var foo: Int { 0 }
                
                    internal func toName() -> Name {
                        switch self {
                        case .a:
                            .a
                        case .b:
                            .b
                        }
                    }
                
                    internal func `is`(_ name: Name) -> Bool {
                        toName() == name
                    }

                    internal nonisolated enum Name: CaseIterable {
                        case a
                        case b
                    }
                }
                """,
            macros: macros
        )
    }
    
    func testSameLineCases() {
        assertMacroExpansion(
            """
            @CaseNameGeneration
            nonisolated enum Model {
                case a, b
                case c
            }
            """,
            expandedSource:
                """
                nonisolated enum Model {
                    case a, b
                    case c
                
                    internal func toName() -> Name {
                        switch self {
                        case .a:
                            .a
                        case .b:
                            .b
                        case .c:
                            .c
                        }
                    }
                
                    internal func `is`(_ name: Name) -> Bool {
                        toName() == name
                    }

                    internal nonisolated enum Name: CaseIterable {
                        case a
                        case b
                        case c
                    }
                }
                """,
            macros: macros
        )
    }
    
    func testNonEnum() {
        assertMacroExpansion(
            """
            @CaseNameGeneration
            nonisolated struct Model {}
            """,
            expandedSource:
                """
                nonisolated struct Model {}
                """,
            diagnostics: [
                DiagnosticSpec(message: "'CaseNameGeneration' macro can only be applied to 'enum's", line: 1, column: 1)
            ],
            macros: macros
        )
    }
}

#endif
