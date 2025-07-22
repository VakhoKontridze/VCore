//
//  EdgeInsetsAxisTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct EdgeInsetsAxisTests {
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsetsAxis(horizontal: 1, vertical: 2).insetBy(inset: 10) ==
            EdgeInsetsAxis(horizontal: 11, vertical: 12)
        )
    }
    
    @Test
    func testInsetHorizontal() {
        #expect(
            EdgeInsetsAxis(horizontal: 1, vertical: 2).insetBy(horizontal: 10) ==
            EdgeInsetsAxis(horizontal: 11, vertical: 2)
        )
    }
    
    @Test
    func testInsetVertical() {
        #expect(
            EdgeInsetsAxis(horizontal: 1, vertical: 2).insetBy(vertical: 10) ==
            EdgeInsetsAxis(horizontal: 1, vertical: 12)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsetsAxis(horizontal: 1, vertical: 2) +
            EdgeInsetsAxis(horizontal: 3, vertical: 4) ==
            EdgeInsetsAxis(horizontal: 4, vertical: 6)
        )
        
        do {
            var insets: EdgeInsetsAxis = .init(horizontal: 1, vertical: 2)
            insets += EdgeInsetsAxis(horizontal: 3, vertical: 4)
            
            #expect(insets == EdgeInsetsAxis(horizontal: 4, vertical: 6))
        }
    }
     
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsetsAxis(horizontal: 1, vertical: 2) -
            EdgeInsetsAxis(horizontal: 3, vertical: 4) ==
            EdgeInsetsAxis(horizontal: -2, vertical: -2)
        )
        
        do {
            var insets: EdgeInsetsAxis = .init(horizontal: 1, vertical: 2)
            insets -= EdgeInsetsAxis(horizontal: 3, vertical: 4)
            
            #expect(insets == EdgeInsetsAxis(horizontal: -2, vertical: -2))
        }
    }
}
