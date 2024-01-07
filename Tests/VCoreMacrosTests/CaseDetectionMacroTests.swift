//
//  CaseDetectionMacroTests.swift
//  VCoreMacrosTests
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

#if canImport(VCoreMacrosImplementation)

import Foundation
import XCTest
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import VCoreMacros
@testable import VCoreMacrosImplementation

// MARK: - Tests
final class CaseDetectionMacroTests: XCTestCase {
    // MARK: Test Data
    private let macros: [String: Macro.Type] = ["CaseDetection": CaseDetectionMacro.self]

    // MARK: Tests
    func test() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum Gender {
                case male
                case female
            }
            """,
            expandedSource: """
                enum Gender {
                    case male
                    case female

                    var isMale: Bool {
                        if case .male = self {
                            true
                        } else {
                            false
                        }
                    }

                    var isFemale: Bool {
                        if case .female = self {
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
