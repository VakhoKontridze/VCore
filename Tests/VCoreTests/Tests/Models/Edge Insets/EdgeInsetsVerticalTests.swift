//
//  EdgeInsetsVerticalTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
struct EdgeInsetsVerticalTests {
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsetsVertical(top: 1, bottom: 2).insetBy(inset: 10) ==
            EdgeInsetsVertical(top: 11, bottom: 12)
        )
    }
    
    @Test
    func testInsetTop() {
        #expect(
            EdgeInsetsVertical(top: 1, bottom: 2).insetBy(top: 10) ==
            EdgeInsetsVertical(top: 11, bottom: 2)
        )
    }
    
    @Test
    func testInsetBottom() {
        #expect(
            EdgeInsetsVertical(top: 1, bottom: 2).insetBy(bottom: 10) ==
            EdgeInsetsVertical(top: 1, bottom: 12)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsetsVertical(top: 1, bottom: 2) +
            EdgeInsetsVertical(top: 3, bottom: 4) ==
            EdgeInsetsVertical(top: 4, bottom: 6)
        )
        
        do {
            var insets: EdgeInsetsVertical = .init(top: 1, bottom: 2)
            insets += EdgeInsetsVertical(top: 3, bottom: 4)
            
            #expect(insets == EdgeInsetsVertical(top: 4, bottom: 6))
        }
    }
    
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsetsVertical(top: 1, bottom: 2) -
            EdgeInsetsVertical(top: 3, bottom: 4) ==
            EdgeInsetsVertical(top: -2, bottom: -2)
        )
        
        do {
            var insets: EdgeInsetsVertical = .init(top: 1, bottom: 2)
            insets -= EdgeInsetsVertical(top: 3, bottom: 4)
            
            #expect(insets == EdgeInsetsVertical(top: -2, bottom: -2))
        }
    }
}
