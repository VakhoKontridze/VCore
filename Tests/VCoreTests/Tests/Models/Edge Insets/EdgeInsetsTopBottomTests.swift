//
//  EdgeInsetsTopBottomTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsTopBottomTests: XCTestCase {
    // MARK: Tests - Insets
    func testInsetInset() {
        let insets: EdgeInsets_TopBottom = .init(
            top: 1,
            bottom: 2
        ).insetBy(inset: 10)

        XCTAssertEqual(insets.top, 11)
        XCTAssertEqual(insets.bottom, 12)
    }
    
    func testInsetTop() {
        let insets: EdgeInsets_TopBottom = .init(
            top: 1,
            bottom: 2
        ).insetBy(top: 10)

        XCTAssertEqual(insets.top, 11)
        XCTAssertEqual(insets.bottom, 2)
    }
    
    func testInsetBottom() {
        let insets: EdgeInsets_TopBottom = .init(
            top: 1,
            bottom: 2
        ).insetBy(bottom: 10)

        XCTAssertEqual(insets.top, 1)
        XCTAssertEqual(insets.bottom, 12)
    }
    
    // MARK: Tests - Operators
    func testAddition() {
        let insets: EdgeInsets_TopBottom =
            EdgeInsets_TopBottom(
                top: 1,
                bottom: 2
            ) +
            EdgeInsets_TopBottom(
                top: 3,
                bottom: 4
            )
        
        XCTAssertEqual(insets.top, 4)
        XCTAssertEqual(insets.bottom, 6)
    }
    
    func testAdditionAssignment() {
        var insets: EdgeInsets_TopBottom = .init(
            top: 1,
            bottom: 2
        )
        insets += EdgeInsets_TopBottom(
            top: 3,
            bottom: 4
        )
        
        XCTAssertEqual(insets.top, 4)
        XCTAssertEqual(insets.bottom, 6)
    }
    
    func testSubtraction() {
        let insets: EdgeInsets_TopBottom =
            EdgeInsets_TopBottom(
                top: 1,
                bottom: 2
            ) -
            EdgeInsets_TopBottom(
                top: 3,
                bottom: 4
            )
        
        XCTAssertEqual(insets.top, -2)
        XCTAssertEqual(insets.bottom, -2)
    }
    
    func testSubtractionAssignment() {
        var insets: EdgeInsets_TopBottom = .init(
            top: 1,
            bottom: 2
        )
        insets -= EdgeInsets_TopBottom(
            top: 3,
            bottom: 4
        )
        
        XCTAssertEqual(insets.top, -2)
        XCTAssertEqual(insets.bottom, -2)
    }
}
