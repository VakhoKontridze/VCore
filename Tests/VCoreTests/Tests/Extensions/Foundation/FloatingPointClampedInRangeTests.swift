//
//  FloatingPointClampedInRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class FloatingPointClampedInRangeTests: XCTestCase {
    private let step: Double = 3
    private let min: Double = 1
    private let max: Double = 10
    private var range: ClosedRange<Double> { min...max }
    
    private let input1: Double = 0
    private let input2: Double = 5
    private let input3: Double = 11
    
    private let output1: Double = 1
    private let output2: Double = 5
    private let output3: Double = 10
    
    private let output1Step: Double = 1
    private let output2Step: Double = 4
    private let output3Step: Double = 10
    
    func testClampedRange() {
        XCTAssertEqual(input1.clamped(in: range), output1)
        XCTAssertEqual(input2.clamped(in: range), output2)
        XCTAssertEqual(input3.clamped(in: range), output3)
    }
    
    func testClampedRangeStep() {
        XCTAssertEqual(input1.clamped(in: range, step: step), output1Step)
        XCTAssertEqual(input2.clamped(in: range, step: step), output2Step)
        XCTAssertEqual(input3.clamped(in: range, step: step), output3Step)
    }
    
    func testClampRange() {
        var result1 = input1; result1.clamp(in: range)
        var result2 = input2; result2.clamp(in: range)
        var result3 = input3; result3.clamp(in: range)
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
    
    func testClampRangeStep() {
        var result1 = input1; result1.clamp(in: range, step: step)
        var result2 = input2; result2.clamp(in: range, step: step)
        var result3 = input3; result3.clamp(in: range, step: step)
        
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
