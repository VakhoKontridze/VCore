//
//  EdgeInsetsTopBottomTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct EdgeInsetsTopBottomTests {
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsets_TopBottom(top: 1, bottom: 2).insetBy(inset: 10) ==
            EdgeInsets_TopBottom(top: 11, bottom: 12)
        )
    }
    
    @Test
    func testInsetTop() {
        #expect(
            EdgeInsets_TopBottom(top: 1, bottom: 2).insetBy(top: 10) ==
            EdgeInsets_TopBottom(top: 11, bottom: 2)
        )
    }
    
    @Test
    func testInsetBottom() {
        #expect(
            EdgeInsets_TopBottom(top: 1, bottom: 2).insetBy(bottom: 10) ==
            EdgeInsets_TopBottom(top: 1, bottom: 12)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsets_TopBottom(top: 1, bottom: 2) +
            EdgeInsets_TopBottom(top: 3, bottom: 4) ==
            EdgeInsets_TopBottom(top: 4, bottom: 6)
        )
        
        do {
            var insets: EdgeInsets_TopBottom = .init(top: 1, bottom: 2)
            insets += EdgeInsets_TopBottom(top: 3, bottom: 4)
            
            #expect(insets == EdgeInsets_TopBottom(top: 4, bottom: 6))
        }
    }
    
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsets_TopBottom(top: 1, bottom: 2) -
            EdgeInsets_TopBottom(top: 3, bottom: 4) ==
            EdgeInsets_TopBottom(top: -2, bottom: -2)
        )
        
        do {
            var insets: EdgeInsets_TopBottom = .init(top: 1, bottom: 2)
            insets -= EdgeInsets_TopBottom(top: 3, bottom: 4)
            
            #expect(insets == EdgeInsets_TopBottom(top: -2, bottom: -2))
        }
    }
}
