//
//  EdgeInsetsHorizontalVerticalTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct EdgeInsetsHorizontalVerticalTests {
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsets_HorizontalVertical(horizontal: 1, vertical: 2).insetBy(inset: 10) ==
            EdgeInsets_HorizontalVertical(horizontal: 11, vertical: 12)
        )
    }
    
    @Test
    func testInsetHorizontal() {
        #expect(
            EdgeInsets_HorizontalVertical(horizontal: 1, vertical: 2).insetBy(horizontal: 10) ==
            EdgeInsets_HorizontalVertical(horizontal: 11, vertical: 2)
        )
    }
    
    @Test
    func testInsetVertical() {
        #expect(
            EdgeInsets_HorizontalVertical(horizontal: 1, vertical: 2).insetBy(vertical: 10) ==
            EdgeInsets_HorizontalVertical(horizontal: 1, vertical: 12)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsets_HorizontalVertical(horizontal: 1, vertical: 2) +
            EdgeInsets_HorizontalVertical(horizontal: 3, vertical: 4) ==
            EdgeInsets_HorizontalVertical(horizontal: 4, vertical: 6)
        )
        
        do {
            var insets: EdgeInsets_HorizontalVertical = .init(horizontal: 1, vertical: 2)
            insets += EdgeInsets_HorizontalVertical(horizontal: 3, vertical: 4)
            
            #expect(insets == EdgeInsets_HorizontalVertical(horizontal: 4, vertical: 6))
        }
    }
     
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsets_HorizontalVertical(horizontal: 1, vertical: 2) -
            EdgeInsets_HorizontalVertical(horizontal: 3, vertical: 4) ==
            EdgeInsets_HorizontalVertical(horizontal: -2, vertical: -2)
        )
        
        do {
            var insets: EdgeInsets_HorizontalVertical = .init(horizontal: 1, vertical: 2)
            insets -= EdgeInsets_HorizontalVertical(horizontal: 3, vertical: 4)
            
            #expect(insets == EdgeInsets_HorizontalVertical(horizontal: -2, vertical: -2))
        }
    }
}
