//
//  BinaryIntegerClampedToRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct BinaryIntegerClampedToRangeTests {
    // MARK: Tests - Range
    @Test
    func testClampedToRange() {
        #expect(0.clamped(to: 1..<11) == 1)
        #expect(5.clamped(to: 1..<11) == 5)
        #expect(11.clamped(to: 1..<11) == 10)
    }
    
    @Test
    func testClampToRange() {
        do {
            var number: Int = 0
            number.clamp(to: 1..<11)
            
            #expect(number == 1)
        }
        
        do {
            var number: Int = 5
            number.clamp(to: 1..<11)
            
            #expect(number == 5)
        }
        
        do {
            var number: Int = 11
            number.clamp(to: 1..<11)
            
            #expect(number == 10)
        }
    }
    
    // MARK: Tests - Range with Step
    @Test
    func testClampedToRangeWithStep() {
        #expect(0.clamped(to: 1..<11, step: 3) == 1)
        #expect(5.clamped(to: 1..<11, step: 3) == 4)
        #expect(11.clamped(to: 1..<11, step: 3) == 10)
    }
    
    @Test
    func testClampToRangeWithStep() {
        do {
            var number: Int = 0
            number.clamp(to: 1..<11, step: 3)
            
            #expect(number == 1)
        }
        
        do {
            var number: Int = 5
            number.clamp(to: 1..<11, step: 3)
            
            #expect(number == 4)
        }
        
        do {
            var number: Int = 11
            number.clamp(to: 1..<11, step: 3)
            
            #expect(number == 10)
        }
    }

    // MARK: Tests - Closed Range
    @Test
    func testClampedToClosedRange() {
        #expect(0.clamped(to: 1...10) == 1)
        #expect(5.clamped(to: 1...10) == 5)
        #expect(11.clamped(to: 1...10) == 10)
    }
    
    @Test
    func testClampToClosedRange() {
        do {
            var number: Int = 0
            number.clamp(to: 1...10)
            
            #expect(number == 1)
        }
        
        do {
            var number: Int = 5
            number.clamp(to: 1...10)
            
            #expect(number == 5)
        }
        
        do {
            var number: Int = 11
            number.clamp(to: 1...10)
            
            #expect(number == 10)
        }
    }
    
    // MARK: Tests - Closed Range with Step
    @Test
    func testClampedToClosedRangeWithStep() {
        #expect(0.clamped(to: 1...10, step: 3) == 1)
        #expect(5.clamped(to: 1...10, step: 3) == 4)
        #expect(11.clamped(to: 1...10, step: 3) == 10)
    }
    
    @Test
    func testClampRangeStep() {
        do {
            var number: Int = 0
            number.clamp(to: 1...10, step: 3)
            
            #expect(number == 1)
        }
        
        do {
            var number: Int = 5
            number.clamp(to: 1...10, step: 3)
            
            #expect(number == 4)
        }
        
        do {
            var number: Int = 11
            number.clamp(to: 1...10, step: 3)
            
            #expect(number == 10)
        }
    }
}
