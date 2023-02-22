//
//  ClampedTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ClampedTests: XCTestCase {
    // MARK: Test Data
    private let range: ClosedRange<Double> = 1...10
    
    private let input1: Double = 0
    private let input2: Double = 5
    private let input3: Double = 11
    
    private let output1: Double = 1
    private let output2: Double = 5
    private let output3: Double = 10
    
    // MARK: Tests
    func testInit() {
        @Clamped(range) var a: Double = input1
        @Clamped(range) var b: Double = input2
        @Clamped(range) var c: Double = input3
        
        XCTAssertEqual(a, output1)
        XCTAssertEqual(b, output2)
        XCTAssertEqual(c, output3)
    }
    
    func testAssignment() {
        @Clamped(range) var value: Double = input1
        
        value = input2
        XCTAssertEqual(value, output2)
        
        value = input3
        XCTAssertEqual(value, output3)
        
        value = input1
        XCTAssertEqual(value, output1)
    }
}
