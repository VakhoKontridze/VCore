//
//  CGSizeScaledTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.09.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CGSizeScaledTests {
    // MARK: Tests - Constant
    @Test
    func testScaledUpWithConstant() {
        #expect(
            CGSize(width: 3, height: 4).scaledUp(withConstant: 1) ==
            CGSize(width: 4, height: 5)
        )
        
        do {
            var size: CGSize = .init(width: 3, height: 4)
            size.scaleUp(withConstant: 1)
            
            #expect(size == CGSize(width: 4, height: 5))
        }
    }
    
    @Test
    func testScaledDownWithConstant() {
        #expect(
            CGSize(width: 3, height: 4).scaledDown(withConstant: 1) ==
            CGSize(width: 2, height: 3)
        )
        
        do {
            var size: CGSize = .init(width: 3, height: 4)
            size.scaleDown(withConstant: 1)
            
            #expect(size == CGSize(width: 2, height: 3))
        }
    }
    
    // MARK: Tests - Multiplier
    @Test
    func testScaledUpWithMultiplier() {
        #expect(
            CGSize(width: 3, height: 4).scaledUp(withMultiplier: 2) ==
            CGSize(width: 6, height: 8)
        )
        
        do {
            var size: CGSize = .init(width: 3, height: 4)
            size.scaleUp(withMultiplier: 2)
            
            #expect(size == CGSize(width: 6, height: 8))
        }
    }
    
    @Test
    func testScaledDownWithMultiplier() {
        #expect(
            CGSize(width: 3, height: 4).scaledDown(withMultiplier: 2) ==
            CGSize(width: 1.5, height: 2)
        )
        
        do {
            var size: CGSize = .init(width: 3, height: 4)
            size.scaleDown(withMultiplier: 2)
            
            #expect(size == CGSize(width: 1.5, height: 2))
        }
    }
}
