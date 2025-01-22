//
//  EdgeInsetsLeadingTrailingTopBottomTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct EdgeInsetsLeadingTrailingTopBottomTests {
    // MARK: Tests - Properties
    @Test
    func testProperties() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        )
        
        #expect(insets.horizontalSum == 3)
        #expect(insets.verticalSum == 7)
        
        #expect(insets.horizontalAverage == 1.5)
        #expect(insets.verticalAverage == 3.5)
    }
     
    // MARK: Tests - Insets
    @Test
    func testInsetAll() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(inset: 10) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 11, trailing: 12, top: 13, bottom: 14)
        )
    }
    
    @Test
    func testInsetHorizontalAndVertical() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(horizontal: 10, vertical: 20) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 11, trailing: 12, top: 23, bottom: 24)
        )
    }
     
    @Test
    func testInsetLeading() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(leading: 10) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 11, trailing: 2, top: 3, bottom: 4)
        )
    }
    
    @Test
    func testInsetTrailing() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(trailing: 10) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 12, top: 3, bottom: 4)
        )
    }
    
    @Test
    func testInsetTop() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(top: 10) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 13, bottom: 4)
        )
    }
    
    @Test
    func testInsetBottom() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(bottom: 10) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 14)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4) +
            EdgeInsets_LeadingTrailingTopBottom(leading: 5, trailing: 6, top: 7, bottom: 8) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: 6, trailing: 8, top: 10, bottom: 12)
        )
        
        do {
            var insets: EdgeInsets_LeadingTrailingTopBottom = .init(leading: 1, trailing: 2, top: 3, bottom: 4)
            insets += EdgeInsets_LeadingTrailingTopBottom(leading: 3, trailing: 4, top: 7, bottom: 8)
            
            #expect(insets == EdgeInsets_LeadingTrailingTopBottom(leading: 4, trailing: 6, top: 10, bottom: 12))
        }
    }
    
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsets_LeadingTrailingTopBottom(leading: 1, trailing: 2, top: 3, bottom: 4) -
            EdgeInsets_LeadingTrailingTopBottom(leading: 5, trailing: 6, top: 7, bottom: 8) ==
            EdgeInsets_LeadingTrailingTopBottom(leading: -4, trailing: -4, top: -4, bottom: -4)
        )
        
        do {
            var insets: EdgeInsets_LeadingTrailingTopBottom = .init(leading: 1, trailing: 2, top: 3, bottom: 4)
            insets -= EdgeInsets_LeadingTrailingTopBottom(leading: 5, trailing: 6, top: 7, bottom: 8)
            
            #expect(insets == EdgeInsets_LeadingTrailingTopBottom(leading: -4, trailing: -4, top: -4, bottom: -4))
        }
    }
}
