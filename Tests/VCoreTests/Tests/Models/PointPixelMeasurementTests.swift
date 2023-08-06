//
//  PointPixelMeasurementTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class PointPixelMeasurementTests: XCTestCase {
    func testPointsConversion() {
        let scale: CGFloat = 3

        let input: PointPixelMeasurement = .pixels(3)
        let output: CGFloat = 1

        let result: CGFloat = input.toPoints(scale: scale)

        XCTAssertEqual(result, output)
    }

    func testPixelsConversion() {
        let scale: CGFloat = 3

        let input: PointPixelMeasurement = .points(1)
        let output: Int = 3

        let result: Int = input.toPixels(scale: scale)

        XCTAssertEqual(result, output)
    }
}
