//
//  UninitializableMacroTests.swift
//  VCoreTests
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

nonisolated final class UninitializableMacroTests: XCTestCase {
    // MARK: Properties
    private let macros: [String: Macro.Type] = ["Uninitializable": UninitializableMacro.self]

    // MARK: Tests
    func test() {
        assertMacroExpansion(
            """
            @Uninitializable
            nonisolated struct AppConstants {
                static let apiKey: String = "..."
            }
            """,
            expandedSource:
                """
                nonisolated struct AppConstants {
                    static let apiKey: String = "..."

                    private init() {
                    }
                }
                """,
            macros: macros
        )
    }
}

#endif
