//
//  PointPixelMeasurementTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct PointPixelMeasurementTests {
    @Test
    func testConvertPixelsToPoints() {
        #expect(PointPixelMeasurement.pixels(3).toPoints(scale: 3) == 1)
    }
    
    @Test
    func testConvertPointsToPixels() {
        #expect(PointPixelMeasurement.points(1).toPixels(scale: 3) == 3)
    }
}
