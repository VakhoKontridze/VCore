//
//  UninitializableMacroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosGenericTestSupport
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacrosImplementation
import XCTest

nonisolated final class UninitializableMacroTests: XCTestCase {
    // MARK: Properties
    private let macros: [String: any Macro.Type] = ["Uninitializable": UninitializableMacro.self]

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
