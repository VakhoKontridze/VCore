//
//  EdgeInsetsHorizontalVerticalTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsHorizontalVerticalTests: XCTestCase {
    // MARK: Tests - Insets
    func testInsetInset() {
        let insets: EdgeInsets_HorizontalVertical = .init(
            horizontal: 1,
            vertical: 2
        ).insetBy(inset: 10)

        XCTAssertEqual(insets.horizontal, 11)
        XCTAssertEqual(insets.vertical, 12)
    }
    
    func testInsetHorizontal() {
        let insets: EdgeInsets_HorizontalVertical = .init(
            horizontal: 1,
            vertical: 2
        ).insetBy(horizontal: 10)

        XCTAssertEqual(insets.horizontal, 11)
        XCTAssertEqual(insets.vertical, 2)
    }
    
    func testInsetVertical() {
        let insets: EdgeInsets_HorizontalVertical = .init(
            horizontal: 1,
            vertical: 2
        ).insetBy(vertical: 10)

        XCTAssertEqual(insets.horizontal, 1)
        XCTAssertEqual(insets.vertical, 12)
    }
    
    // MARK: Tests - Operators
    func testAddition() {
        let insets: EdgeInsets_HorizontalVertical =
            EdgeInsets_HorizontalVertical(
                horizontal: 1,
                vertical: 2
            ) +
            EdgeInsets_HorizontalVertical(
                horizontal: 3,
                vertical: 4
            )
        
        XCTAssertEqual(insets.horizontal, 4)
        XCTAssertEqual(insets.vertical, 6)
    }
    
    func testAdditionAssignment() {
        var insets: EdgeInsets_HorizontalVertical = .init(
            horizontal: 1,
            vertical: 2
        )
        insets += EdgeInsets_HorizontalVertical(
            horizontal: 3,
            vertical: 4
        )
        
        XCTAssertEqual(insets.horizontal, 4)
        XCTAssertEqual(insets.vertical, 6)
    }
    
    func testSubtraction() {
        let insets: EdgeInsets_HorizontalVertical =
            EdgeInsets_HorizontalVertical(
                horizontal: 1,
                vertical: 2
            ) -
            EdgeInsets_HorizontalVertical(
                horizontal: 3,
                vertical: 4
            )
        
        XCTAssertEqual(insets.horizontal, -2)
        XCTAssertEqual(insets.vertical, -2)
    }
    
    func testSubtractionAssignment() {
        var insets: EdgeInsets_HorizontalVertical = .init(
            horizontal: 1,
            vertical: 2
        )
        insets -= EdgeInsets_HorizontalVertical(
            horizontal: 3,
            vertical: 4
        )
        
        XCTAssertEqual(insets.horizontal, -2)
        XCTAssertEqual(insets.vertical, -2)
    }
}
