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
            enum PixelPointMeasurement {
                case pixel
                case point(displayScale: CGFloat)
            }
            """,
            expandedSource: """
                enum PixelPointMeasurement {
                    case pixel
                    case point(displayScale: CGFloat)

                    var isPixel: Bool {
                        if case .pixel = self {
                            true
                        } else {
                            false
                        }
                    }

                    var isPoint: Bool {
                        if case .point = self {
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
