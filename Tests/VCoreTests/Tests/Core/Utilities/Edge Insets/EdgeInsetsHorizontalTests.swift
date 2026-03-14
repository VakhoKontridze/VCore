//
//  EdgeInsetsHorizontalTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct EdgeInsetsHorizontalTests {
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsetsHorizontal(leading: 1, trailing: 2).insetBy(inset: 10) ==
            EdgeInsetsHorizontal(leading: 11, trailing: 12)
        )
    }
    
    @Test
    func testInsetLeading() {
        #expect(
            EdgeInsetsHorizontal(leading: 1, trailing: 2).insetBy(leading: 10) ==
            EdgeInsetsHorizontal(leading: 11, trailing: 2)
        )
    }
    
    @Test
    func testInsetTrailing() {
        #expect(
            EdgeInsetsHorizontal(leading: 1, trailing: 2).insetBy(trailing: 10) ==
            EdgeInsetsHorizontal(leading: 1, trailing: 12)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsetsHorizontal(leading: 1, trailing: 2) +
            EdgeInsetsHorizontal(leading: 3, trailing: 4) ==
            EdgeInsetsHorizontal(leading: 4, trailing: 6)
        )
        
        do {
            var insets: EdgeInsetsHorizontal = .init(leading: 1, trailing: 2)
            insets += EdgeInsetsHorizontal(leading: 3, trailing: 4)
            
            #expect(insets == EdgeInsetsHorizontal(leading: 4, trailing: 6))
        }
    }
    
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsetsHorizontal(leading: 1, trailing: 2) -
            EdgeInsetsHorizontal(leading: 3, trailing: 4) ==
            EdgeInsetsHorizontal(leading: -2, trailing: -2)
        )
        
        do {
            var insets: EdgeInsetsHorizontal = .init(leading: 1, trailing: 2)
            insets -= EdgeInsetsHorizontal(leading: 3, trailing: 4)
            
            #expect(insets == EdgeInsetsHorizontal(leading: -2, trailing: -2))
        }
    }
}
