//
//  FloatingPointClampedToClosedRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct FloatingPointClampedToClosedRangeTests {
    // MARK: Tests - Closed Range
    @Test
    func testClampedToClosedRange() {
        #expect(0.0.clamped(to: 1...10) == 1)
        #expect(5.0.clamped(to: 1...10) == 5)
        #expect(11.0.clamped(to: 1...10) == 10)
    }
    
    @Test
    func testClampToClosedRange() {
        do {
            var number: Double = 0
            number.clamp(to: 1...10)
            
            #expect(number == 1)
        }
        
        do {
            var number: Double = 5
            number.clamp(to: 1...10)
            
            #expect(number == 5)
        }
        
        do {
            var number: Double = 11
            number.clamp(to: 1...10)
            
            #expect(number == 10)
        }
    }
    
    // MARK: Tests - Closed Range with Step
    @Test
    func testClampedToClosedRangeWithStep() {
        #expect(0.0.clamped(to: 1...10, step: 3) == 1)
        #expect(5.0.clamped(to: 1...10, step: 3) == 4)
        #expect(11.0.clamped(to: 1...10, step: 3) == 10)
    }
    
    @Test
    func testClampRangeStep() {
        do {
            var number: Double = 0
            number.clamp(to: 1...10, step: 3)
            
            #expect(number == 1)
        }
        
        do {
            var number: Double = 5
            number.clamp(to: 1...10, step: 3)
            
            #expect(number == 4)
        }
        
        do {
            var number: Double = 11
            number.clamp(to: 1...10, step: 3)
            
            #expect(number == 10)
        }
    }
}
