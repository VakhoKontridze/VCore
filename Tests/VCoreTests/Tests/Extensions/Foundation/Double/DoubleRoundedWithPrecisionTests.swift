//
//  DoubleRoundedWithPrecisionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class DoubleRoundedWithPrecisionTests: XCTestCase {
    func testRounded() {
        XCTAssertEqual(3.1415.rounded(fractions: 0), 3)
        XCTAssertEqual(3.1415.rounded(fractions: 1), 3.1)
        XCTAssertEqual(3.1415.rounded(fractions: 2), 3.14)
        XCTAssertEqual(3.1415.rounded(fractions: 3), 3.142)
        XCTAssertEqual(3.1415.rounded(fractions: 4), 3.1415)
        XCTAssertEqual(3.1415.rounded(fractions: 5), 3.1415)
    }
    
    func testRound() {
        var value1: Double = 3.1415
        value1.round(fractions: 0)
        XCTAssertEqual(value1, 3)

        var value2: Double = 3.1415
        value2.round(fractions: 1)
        XCTAssertEqual(value2, 3.1)

        var value3: Double = 3.1415
        value3.round(fractions: 2)
        XCTAssertEqual(value3, 3.14)

        var value4: Double = 3.1415
        value4.round(fractions: 3)
        XCTAssertEqual(value4, 3.142)

        var value5: Double = 3.1415
        value5.round(fractions: 4)
        XCTAssertEqual(value5, 3.1415)

        var value6: Double = 3.1415
        value6.round(fractions: 5)
        XCTAssertEqual(value6, 3.1415)
    }
}
