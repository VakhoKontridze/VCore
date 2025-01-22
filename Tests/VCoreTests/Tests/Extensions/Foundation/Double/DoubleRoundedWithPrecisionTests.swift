//
//  DoubleRoundedWithPrecisionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct DoubleRoundedWithPrecisionTests {
    @Test
    func testRounded() {
        #expect(3.1415.rounded(fractions: 0) == 3)
        #expect(3.1415.rounded(fractions: 1) == 3.1)
        #expect(3.1415.rounded(fractions: 2) == 3.14)
        #expect(3.1415.rounded(fractions: 3) == 3.142)
        #expect(3.1415.rounded(fractions: 4) == 3.1415)
        #expect(3.1415.rounded(fractions: 5) == 3.1415)
    }
    
    @Test
    func testRound() {
        do {
            var value: Double = 3.1415
            value.round(fractions: 0)
            
            #expect(value == 3)
        }

        do {
            var value: Double = 3.1415
            value.round(fractions: 1)
            
            #expect(value == 3.1)
        }

        do {
            var value: Double = 3.1415
            value.round(fractions: 2)
            
            #expect(value == 3.14)
        }

        do {
            var value: Double = 3.1415
            value.round(fractions: 3)
            
            #expect(value == 3.142)
        }

        do {
            var value: Double = 3.1415
            value.round(fractions: 4)
            
            #expect(value == 3.1415)
        }

        do {
            var value: Double = 3.1415
            value.round(fractions: 5)
            
            #expect(value == 3.1415)
        }
    }
}
