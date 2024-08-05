//
//  AbsoluteFractionMeasurementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 16.07.24.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class AbsoluteFractionMeasurementTests: XCTestCase {
    func testPointsConversion() {
        let measurement: AbsoluteFractionMeasurement = .absolute(300)

        let value: CGFloat = measurement.toFraction(dimension: 600)

        XCTAssertEqual(value, 0.5)
    }

    func testPixelsConversion() {
        let measurement: AbsoluteFractionMeasurement = .fraction(0.5)

        let value: CGFloat = measurement.toAbsolute(dimension: 600)

        XCTAssertEqual(value, 300)
    }
}
