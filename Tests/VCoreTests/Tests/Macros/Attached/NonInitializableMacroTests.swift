//
//  NonInitializableMacroTests.swift
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
final class NonInitializableMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["NonInitializable": NonInitializableMacro.self]

    // MARK: Tests
    func test() {
        assertMacroExpansion(
            """
            @NonInitializable
            struct AppConstants {
                static let apiKey: String = "..."
            }
            """,
            expandedSource:
                """
                struct AppConstants {
                    static let apiKey: String = "..."

                    private init() {
                    }
                }
                """
            ,
            macros: macros
        )
    }
}

#endif
