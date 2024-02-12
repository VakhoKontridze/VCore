//
//  EdgeInsetsLeadingTrailingTopBottomTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsLeadingTrailingTopBottomTests: XCTestCase {
    // MARK: Tests - Properties
    func testProperties() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        )
        
        XCTAssertEqual(insets.horizontalSum, 3)
        XCTAssertEqual(insets.verticalSum, 7)

        XCTAssertEqual(insets.horizontalAverage, 1.5)
        XCTAssertEqual(insets.verticalAverage, 3.5)
    }
    
    // MARK: Tests - Insets
    func testInsetInset() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        ).insetBy(inset: 10)

        XCTAssertEqual(insets.leading, 11)
        XCTAssertEqual(insets.trailing, 12)
        XCTAssertEqual(insets.top, 13)
        XCTAssertEqual(insets.bottom, 14)
    }
    
    func testInsetHorizontalVertical() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        ).insetBy(
            horizontal: 10,
            vertical: 10
        )
        
        XCTAssertEqual(insets.leading, 11)
        XCTAssertEqual(insets.trailing, 12)
        XCTAssertEqual(insets.top, 13)
        XCTAssertEqual(insets.bottom, 14)
    }
    
    func testInsetLeading() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        ).insetBy(leading: 10)

        XCTAssertEqual(insets.leading, 11)
        XCTAssertEqual(insets.trailing, 2)
        XCTAssertEqual(insets.top, 3)
        XCTAssertEqual(insets.bottom, 4)
    }
    
    func testInsetTrailing() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        ).insetBy(trailing: 10)

        XCTAssertEqual(insets.leading, 1)
        XCTAssertEqual(insets.trailing, 12)
        XCTAssertEqual(insets.top, 3)
        XCTAssertEqual(insets.bottom, 4)
    }
    
    func testInsetTop() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        ).insetBy(top: 10)

        XCTAssertEqual(insets.leading, 1)
        XCTAssertEqual(insets.trailing, 2)
        XCTAssertEqual(insets.top, 13)
        XCTAssertEqual(insets.bottom, 4)
    }
    
    func testInsetBottom() {
        let insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        ).insetBy(bottom: 10)
        
        XCTAssertEqual(insets.leading, 1)
        XCTAssertEqual(insets.trailing, 2)
        XCTAssertEqual(insets.top, 3)
        XCTAssertEqual(insets.bottom, 14)
    }
    
    // MARK: Tests - Operators
    func testAddition() {
        let insets: EdgeInsets_LeadingTrailingTopBottom =
            EdgeInsets_LeadingTrailingTopBottom(
                leading: 1,
                trailing: 2,
                top: 3,
                bottom: 4
            ) +
            EdgeInsets_LeadingTrailingTopBottom(
                leading: 5,
                trailing: 6,
                top: 7,
                bottom: 8
            )
        
        XCTAssertEqual(insets.leading, 6)
        XCTAssertEqual(insets.trailing, 8)
        XCTAssertEqual(insets.top, 10)
        XCTAssertEqual(insets.bottom, 12)
    }
    
    func testAdditionAssignment() {
        var insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        )
        insets += EdgeInsets_LeadingTrailingTopBottom(
            leading: 5,
            trailing: 6,
            top: 7,
            bottom: 8
        )
        
        XCTAssertEqual(insets.leading, 6)
        XCTAssertEqual(insets.trailing, 8)
        XCTAssertEqual(insets.top, 10)
        XCTAssertEqual(insets.bottom, 12)
    }
    
    func testSubtraction() {
        let insets: EdgeInsets_LeadingTrailingTopBottom =
            EdgeInsets_LeadingTrailingTopBottom(
                leading: 1,
                trailing: 2,
                top: 3,
                bottom: 4
            ) -
            EdgeInsets_LeadingTrailingTopBottom(
                leading: 5,
                trailing: 6,
                top: 7,
                bottom: 8
            )
        
        XCTAssertEqual(insets.leading, -4)
        XCTAssertEqual(insets.trailing, -4)
        XCTAssertEqual(insets.top, -4)
        XCTAssertEqual(insets.bottom, -4)
    }
    
    func testSubtractionAssignment() {
        var insets: EdgeInsets_LeadingTrailingTopBottom = .init(
            leading: 1,
            trailing: 2,
            top: 3,
            bottom: 4
        )
        insets -= EdgeInsets_LeadingTrailingTopBottom(
            leading: 5,
            trailing: 6,
            top: 7,
            bottom: 8
        )
        
        XCTAssertEqual(insets.leading, -4)
        XCTAssertEqual(insets.trailing, -4)
        XCTAssertEqual(insets.top, -4)
        XCTAssertEqual(insets.bottom, -4)
    }
}
