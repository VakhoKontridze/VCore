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
    // MARK: Test Data - Int
    private let rangeInt: ClosedRange<Int> = 1...10
    
    private let input1Int: Int = 0
    private let input2Int: Int = 5
    private let input3Int: Int = 11
    
    private let output1Int: Int = 1
    private let output2Int: Int = 5
    private let output3Int: Int = 10
    
    // MARK: Test Data - Double
    private let rangeDouble: ClosedRange<Double> = 1...10
    private let stepDouble: Double = 3
    
    private let input1Double: Double = 0
    private let input2Double: Double = 5
    private let input3Double: Double = 11
    
    private let output1Double: Double = 1
    private let output2Double: Double = 5
    private let output3Double: Double = 10
    
    private let output1DoubleStep: Double = 1
    private let output2DoubleStep: Double = 4
    private let output3DoubleStep: Double = 10
    
    // MARK: Tests
    func testIntAndInit() {
        @Clamped(rangeInt) var result1: Int = input1Int
        @Clamped(rangeInt) var result2: Int = input2Int
        @Clamped(rangeInt) var result3: Int = input3Int
        
        XCTAssertEqual(result1, output1Int)
        XCTAssertEqual(result2, output2Int)
        XCTAssertEqual(result3, output3Int)
    }
    
    func testIntAndAssignment() {
        @Clamped(rangeInt) var result: Int = input1Int
        
        result = input2Int
        XCTAssertEqual(result, output2Int)
        
        result = input3Int
        XCTAssertEqual(result, output3Int)
        
        result = input1Int
        XCTAssertEqual(result, output1Int)
    }
    
    func testDoubleAndInit() {
        @Clamped(rangeDouble) var result1: Double = input1Double
        @Clamped(rangeDouble) var result2: Double = input2Double
        @Clamped(rangeDouble) var result3: Double = input3Double
        
        XCTAssertEqual(result1, output1Double)
        XCTAssertEqual(result2, output2Double)
        XCTAssertEqual(result3, output3Double)
    }
    
    func testDoubleAndInitStep() {
        @Clamped(rangeDouble, step: stepDouble) var result1: Double = input1Double
        @Clamped(rangeDouble, step: stepDouble) var result2: Double = input2Double
        @Clamped(rangeDouble, step: stepDouble) var result3: Double = input3Double
        
        XCTAssertEqual(result1, output1DoubleStep)
        XCTAssertEqual(result2, output2DoubleStep)
        XCTAssertEqual(result3, output3DoubleStep)
    }
}
