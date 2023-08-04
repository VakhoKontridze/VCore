//
//  BinaryIntegerClampedToRangeTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class BinaryIntegerClampedToRangeTests: XCTestCase {
    // MARK: Test Data
    private let step: Int = 3
    private let min: Int = 1
    private let max: Int = 11
    private var range: Range<Int> { min..<max }
    
    private let input1: Int = 0
    private let input2: Int = 5
    private let input3: Int = 11
    
    private let output1: Int = 1
    private let output2: Int = 5
    private let output3: Int = 10
    
    private let output1Step: Int = 1
    private let output2Step: Int = 4
    private let output3Step: Int = 10
    
    // MARK: Tests
    func testClampedRange() {
        XCTAssertEqual(input1.clamped(to: range), output1)
        XCTAssertEqual(input2.clamped(to: range), output2)
        XCTAssertEqual(input3.clamped(to: range), output3)
    }
    
    func testClampedRangeStep() {
        XCTAssertEqual(input1.clamped(to: range, step: step), output1Step)
        XCTAssertEqual(input2.clamped(to: range, step: step), output2Step)
        XCTAssertEqual(input3.clamped(to: range, step: step), output3Step)
    }
    
    func testClampRange() {
        var result1 = input1; result1.clamp(to: range)
        var result2 = input2; result2.clamp(to: range)
        var result3 = input3; result3.clamp(to: range)
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
    
    func testClampRangeStep() {
        var result1 = input1; result1.clamp(to: range, step: step)
        var result2 = input2; result2.clamp(to: range, step: step)
        var result3 = input3; result3.clamp(to: range, step: step)
        
        XCTAssertEqual(result1, output1Step)
        XCTAssertEqual(result2, output2Step)
        XCTAssertEqual(result3, output3Step)
    }
}

// MARK: - Tests
final class BinaryIntegerClampedToClosedRangeTests: XCTestCase {
    // MARK: Test Data
    private let step: Int = 3
    private let min: Int = 1
    private let max: Int = 10
    private var range: ClosedRange<Int> { min...max }
    
    private let input1: Int = 0
    private let input2: Int = 5
    private let input3: Int = 11
    
    private let output1: Int = 1
    private let output2: Int = 5
    private let output3: Int = 10
    
    private let output1Step: Int = 1
    private let output2Step: Int = 4
    private let output3Step: Int = 10
    
    // MARK: Tests
    func testClampedRange() {
        XCTAssertEqual(input1.clamped(to: range), output1)
        XCTAssertEqual(input2.clamped(to: range), output2)
        XCTAssertEqual(input3.clamped(to: range), output3)
    }
    
    func testClampedRangeStep() {
        XCTAssertEqual(input1.clamped(to: range, step: step), output1Step)
        XCTAssertEqual(input2.clamped(to: range, step: step), output2Step)
        XCTAssertEqual(input3.clamped(to: range, step: step), output3Step)
    }
    
    func testClampRange() {
        var result1 = input1; result1.clamp(to: range)
        var result2 = input2; result2.clamp(to: range)
        var result3 = input3; result3.clamp(to: range)
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
    
    func testClampRangeStep() {
        var result1 = input1; result1.clamp(to: range, step: step)
        var result2 = input2; result2.clamp(to: range, step: step)
        var result3 = input3; result3.clamp(to: range, step: step)
        
        XCTAssertEqual(result1, output1Step)
        XCTAssertEqual(result2, output2Step)
        XCTAssertEqual(result3, output3Step)
    }
    
    func testClampedMinMax() {
        XCTAssertEqual(input1.clamped(min: min, max: max), output1)
        XCTAssertEqual(input2.clamped(min: min, max: max), output2)
        XCTAssertEqual(input3.clamped(min: min, max: max), output3)
    }
    
    func testClampedMinMaxStep() {
        XCTAssertEqual(input1.clamped(min: min, max: max, step: step), output1Step)
        XCTAssertEqual(input2.clamped(min: min, max: max, step: step), output2Step)
        XCTAssertEqual(input3.clamped(min: min, max: max, step: step), output3Step)
    }
    
    func testClampMinMax() {
        var result1 = input1; result1.clamp(min: min, max: max)
        var result2 = input2; result2.clamp(min: min, max: max)
        var result3 = input3; result3.clamp(min: min, max: max)
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
    
    func testClampMinMaxStep() {
        var result1 = input1; result1.clamp(min: min, max: max, step: step)
        var result2 = input2; result2.clamp(min: min, max: max, step: step)
        var result3 = input3; result3.clamp(min: min, max: max, step: step)
        
        XCTAssertEqual(result1, output1Step)
        XCTAssertEqual(result2, output2Step)
        XCTAssertEqual(result3, output3Step)
    }
}
