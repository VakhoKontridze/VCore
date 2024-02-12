//
//  PointPixelMeasurementTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class PointPixelMeasurementTests: XCTestCase {
    func testPointsConversion() {
        let measurement: PointPixelMeasurement = .pixels(3)

        let value: CGFloat = measurement.toPoints(scale: 3)

        XCTAssertEqual(value, 1)
    }

    func testPixelsConversion() {
        let measurement: PointPixelMeasurement = .points(1)

        let value: Int = measurement.toPixels(scale: 3)

        XCTAssertEqual(value, 3)
    }
}
