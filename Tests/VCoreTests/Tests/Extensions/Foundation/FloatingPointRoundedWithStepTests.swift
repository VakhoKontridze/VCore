//
//  FloatingPointRoundedWithStepTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class FloatingPointRoundedWithStepTests: XCTestCase {
    private let step: Double = 3
    private let min: Double = 1
    private let max: Double = 10
    private var range: ClosedRange<Double> { min...max }
    
    private let input1: Double = 0
    private let input2: Double = 5
    private let input3: Double = 10
    
    private let output1: Double = 1
    private let output2: Double = 4
    private let output3: Double = 10
    
    func testRounded() {
        XCTAssertEqual(input1.rounded(range: range, step: step), output1)
        XCTAssertEqual(input2.rounded(range: range, step: step), output2)
        XCTAssertEqual(input3.rounded(range: range, step: step), output3)
    }
    
    func testRound() {
        var result1 = input1; result1.round(range: range, step: step)
        var result2 = input2; result2.round(range: range, step: step)
        var result3 = input3; result3.round(range: range, step: step)
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
}
