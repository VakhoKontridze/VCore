//
//  EdgeInsetsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import SwiftUI
import Testing
@testable import VCore

@Suite
struct EdgeInsetsTests {
    // MARK: Tests - Properties
    @Test
    func testProperties() {
        let insets: EdgeInsets = .init(
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
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(inset: 10) ==
            EdgeInsets(leading: 11, trailing: 12, top: 13, bottom: 14)
        )
    }
    
    @Test
    func testInsetHorizontalAndVertical() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(horizontal: 10, vertical: 20) ==
            EdgeInsets(leading: 11, trailing: 12, top: 23, bottom: 24)
        )
    }
     
    @Test
    func testInsetLeading() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(leading: 10) ==
            EdgeInsets(leading: 11, trailing: 2, top: 3, bottom: 4)
        )
    }
    
    @Test
    func testInsetTrailing() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(trailing: 10) ==
            EdgeInsets(leading: 1, trailing: 12, top: 3, bottom: 4)
        )
    }
    
    @Test
    func testInsetTop() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(top: 10) ==
            EdgeInsets(leading: 1, trailing: 2, top: 13, bottom: 4)
        )
    }
    
    @Test
    func testInsetBottom() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4).insetBy(bottom: 10) ==
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 14)
        )
    }
    
    // MARK: Tests - Operators
    @Test
    func testAddition() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4) +
            EdgeInsets(leading: 5, trailing: 6, top: 7, bottom: 8) ==
            EdgeInsets(leading: 6, trailing: 8, top: 10, bottom: 12)
        )
        
        do {
            var insets: EdgeInsets = .init(leading: 1, trailing: 2, top: 3, bottom: 4)
            insets += EdgeInsets(leading: 3, trailing: 4, top: 7, bottom: 8)
            
            #expect(insets == EdgeInsets(leading: 4, trailing: 6, top: 10, bottom: 12))
        }
    }
    
    @Test
    func testSubtraction() {
        #expect(
            EdgeInsets(leading: 1, trailing: 2, top: 3, bottom: 4) -
            EdgeInsets(leading: 5, trailing: 6, top: 7, bottom: 8) ==
            EdgeInsets(leading: -4, trailing: -4, top: -4, bottom: -4)
        )
        
        do {
            var insets: EdgeInsets = .init(leading: 1, trailing: 2, top: 3, bottom: 4)
            insets -= EdgeInsets(leading: 5, trailing: 6, top: 7, bottom: 8)
            
            #expect(insets == EdgeInsets(leading: -4, trailing: -4, top: -4, bottom: -4))
        }
    }
}
