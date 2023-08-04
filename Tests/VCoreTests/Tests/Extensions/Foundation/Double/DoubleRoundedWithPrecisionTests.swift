//
//  DoubleRoundedWithPrecisionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class DoubleRoundedWithPrecisionTests: XCTestCase {
    // MARK: Test Data
    private let input: Double = 3.1415
    
    private let output1: Double = 3
    private let output2: Double = 3.1
    private let output3: Double = 3.14
    private let output4: Double = 3.142
    private let output5: Double = 3.1415
    private let output6: Double = 3.1415
    
    // MARK: Tests
    func testRounded() {
        XCTAssertEqual(input.rounded(fractions: 0), output1)
        XCTAssertEqual(input.rounded(fractions: 1), output2)
        XCTAssertEqual(input.rounded(fractions: 2), output3)
        XCTAssertEqual(input.rounded(fractions: 3), output4)
        XCTAssertEqual(input.rounded(fractions: 4), output5)
        XCTAssertEqual(input.rounded(fractions: 5), output6)
    }
    
    func testRound() {
        var result1: Double = input
        result1.round(fractions: 0)
        XCTAssertEqual(result1, output1)
        
        var result2: Double = input
        result2.round(fractions: 1)
        XCTAssertEqual(result2, output2)
        
        var result3: Double = input
        result3.round(fractions: 2)
        XCTAssertEqual(result3, output3)
        
        var result4: Double = input
        result4.round(fractions: 3)
        XCTAssertEqual(result4, output4)
        
        var result5: Double = input
        result5.round(fractions: 4)
        XCTAssertEqual(result5, output5)
        
        var result6: Double = input
        result6.round(fractions: 5)
        XCTAssertEqual(result6, output6)
    }
}
