//
//  FloatingPointClampedToClosedRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class FloatingPointClampedToClosedRangeTests: XCTestCase {
    func testClampedRange() {
        XCTAssertEqual(0.0.clamped(to: 1...10), 1)
        XCTAssertEqual(5.0.clamped(to: 1...10), 5)
        XCTAssertEqual(11.0.clamped(to: 1...10), 10)
    }
    
    func testClampedRangeStep() {
        XCTAssertEqual(0.0.clamped(to: 1...10, step: 3), 1)
        XCTAssertEqual(5.0.clamped(to: 1...10, step: 3), 4)
        XCTAssertEqual(11.0.clamped(to: 1...10, step: 3), 10)
    }
    
    func testClampRange() {
        var clampedNumber1: Double = 0; clampedNumber1.clamp(to: 1...10)
        var clampedNumber2: Double = 5; clampedNumber2.clamp(to: 1...10)
        var clampedNumber3: Double = 11; clampedNumber3.clamp(to: 1...10)

        XCTAssertEqual(clampedNumber1, 1)
        XCTAssertEqual(clampedNumber2, 5)
        XCTAssertEqual(clampedNumber3, 10)
    }
    
    func testClampRangeStep() {
        var clampedNumber1: Double = 0; clampedNumber1.clamp(to: 1...10, step: 3)
        var clampedNumber2: Double = 5; clampedNumber2.clamp(to: 1...10, step: 3)
        var clampedNumber3: Double = 11; clampedNumber3.clamp(to: 1...10, step: 3)

        XCTAssertEqual(clampedNumber1, 1)
        XCTAssertEqual(clampedNumber2, 4)
        XCTAssertEqual(clampedNumber3, 10)
    }
    
    func testClampedMinMax() {
        XCTAssertEqual(0.0.clamped(min: 1, max: 10), 1)
        XCTAssertEqual(5.0.clamped(min: 1, max: 10), 5)
        XCTAssertEqual(11.0.clamped(min: 1, max: 10), 10)
    }
    
    func testClampedMinMaxStep() {
        XCTAssertEqual(0.0.clamped(min: 1, max: 10, step: 3), 1)
        XCTAssertEqual(5.0.clamped(min: 1, max: 10, step: 3), 4)
        XCTAssertEqual(11.0.clamped(min: 1, max: 10, step: 3), 10)
    }
    
    func testClampMinMax() {
        var clampedNumber1: Double = 0; clampedNumber1.clamp(min: 1, max: 10)
        var clampedNumber2: Double = 5; clampedNumber2.clamp(min: 1, max: 10)
        var clampedNumber3: Double = 11; clampedNumber3.clamp(min: 1, max: 10)

        XCTAssertEqual(clampedNumber1, 1)
        XCTAssertEqual(clampedNumber2, 5)
        XCTAssertEqual(clampedNumber3, 10)
    }
    
    func testClampMinMaxStep() {
        var clampedNumber1: Double = 0; clampedNumber1.clamp(min: 1, max: 10, step: 3)
        var clampedNumber2: Double = 5; clampedNumber2.clamp(min: 1, max: 10, step: 3)
        var clampedNumber3: Double = 11; clampedNumber3.clamp(min: 1, max: 10, step: 3)

        XCTAssertEqual(clampedNumber1, 1)
        XCTAssertEqual(clampedNumber2, 4)
        XCTAssertEqual(clampedNumber3, 10)
    }
}
