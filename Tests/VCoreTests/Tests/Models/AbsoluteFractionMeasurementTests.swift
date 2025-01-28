//
//  AbsoluteFractionMeasurementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 16.07.24.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct AbsoluteFractionMeasurementTests {
    @Test
    func testConvertAbsoluteToFraction() {
        #expect(AbsoluteFractionMeasurement.absolute(300).toFraction(dimension: 600) == 0.5)
    }
    
    @Test
    func testConvertFractionToAbsolute() {
        #expect(AbsoluteFractionMeasurement.fraction(0.5).toAbsolute(dimension: 600) == 300)
    }
}
