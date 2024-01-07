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
    func test() {
        assertMacroExpansion(
            """
            @CaseDetection
            public enum PointPixelMeasurement {
                case points(displayScale: CGFloat)
                case pixels
            }
            """,
            expandedSource: """
                public enum PointPixelMeasurement {
                    case points(displayScale: CGFloat)
                    case pixels

                    /// Indicates if `PointPixelMeasurement` is `points`.
                    public var isPoints: Bool {
                        if case .points = self {
                            true
                        } else {
                            false
                        }
                    }

                    /// Indicates if `PointPixelMeasurement` is `pixels`.
                    public var isPixels: Bool {
                        if case .pixels = self {
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
