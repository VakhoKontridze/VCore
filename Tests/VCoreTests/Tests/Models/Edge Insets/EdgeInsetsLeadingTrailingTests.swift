//
//  EdgeInsetsLeadingTrailingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct EdgeInsetsLeadingTrailingTests {
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsets_LeadingTrailing(leading: 1, trailing: 2).insetBy(inset: 10) ==
            EdgeInsets_LeadingTrailing(leading: 11, trailing: 12)
        )
    }
    
    @Test
    func testInsetLeading() {
        #expect(
            EdgeInsets_LeadingTrailing(leading: 1, trailing: 2).insetBy(leading: 10) ==
            EdgeInsets_LeadingTrailing(leading: 11, trailing: 2)
        )
    }
    
    @Test
    func testInsetTrailing() {
        #expect(
            EdgeInsets_LeadingTrailing(leading: 1, trailing: 2).insetBy(trailing: 10) ==
            EdgeInsets_LeadingTrailing(leading: 1, trailing: 12)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsets_LeadingTrailing(leading: 1, trailing: 2) +
            EdgeInsets_LeadingTrailing(leading: 3, trailing: 4) ==
            EdgeInsets_LeadingTrailing(leading: 4, trailing: 6)
        )
        
        do {
            var insets: EdgeInsets_LeadingTrailing = .init(leading: 1, trailing: 2)
            insets += EdgeInsets_LeadingTrailing(leading: 3, trailing: 4)
            
            #expect(insets == EdgeInsets_LeadingTrailing(leading: 4, trailing: 6))
        }
    }
    
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsets_LeadingTrailing(leading: 1, trailing: 2) -
            EdgeInsets_LeadingTrailing(leading: 3, trailing: 4) ==
            EdgeInsets_LeadingTrailing(leading: -2, trailing: -2)
        )
        
        do {
            var insets: EdgeInsets_LeadingTrailing = .init(leading: 1, trailing: 2)
            insets -= EdgeInsets_LeadingTrailing(leading: 3, trailing: 4)
            
            #expect(insets == EdgeInsets_LeadingTrailing(leading: -2, trailing: -2))
        }
    }
}
