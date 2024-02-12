//
//  EdgeInsetsLeadingTrailingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class EdgeInsetsLeadingTrailingTests: XCTestCase {
    // MARK: Tests - Insets
    func testInsetInset() {
        let insets: EdgeInsets_LeadingTrailing = .init(
            leading: 1,
            trailing: 2
        ).insetBy(inset: 10)

        XCTAssertEqual(insets.leading, 11)
        XCTAssertEqual(insets.trailing, 12)
    }
    
    func testInsetLeading() {
        let insets: EdgeInsets_LeadingTrailing = .init(
            leading: 1,
            trailing: 2
        ).insetBy(leading: 10)

        XCTAssertEqual(insets.leading, 11)
        XCTAssertEqual(insets.trailing, 2)
    }
    
    func testInsetTrailing() {
        let insets: EdgeInsets_LeadingTrailing = .init(
            leading: 1,
            trailing: 2
        ).insetBy(trailing: 10)

        XCTAssertEqual(insets.leading, 1)
        XCTAssertEqual(insets.trailing, 12)
    }
    
    // MARK: Tests - Operators
    func testAddition() {
        let insets: EdgeInsets_LeadingTrailing =
            EdgeInsets_LeadingTrailing(
                leading: 1,
                trailing: 2
            ) +
            EdgeInsets_LeadingTrailing(
                leading: 3,
                trailing: 4
            )
        
        XCTAssertEqual(insets.leading, 4)
        XCTAssertEqual(insets.trailing, 6)
    }
    
    func testAdditionAssignment() {
        var insets: EdgeInsets_LeadingTrailing = .init(
            leading: 1,
            trailing: 2
        )
        insets += EdgeInsets_LeadingTrailing(
            leading: 3,
            trailing: 4
        )
        
        XCTAssertEqual(insets.leading, 4)
        XCTAssertEqual(insets.trailing, 6)
    }
    
    func testSubtraction() {
        let insets: EdgeInsets_LeadingTrailing =
            EdgeInsets_LeadingTrailing(
                leading: 1,
                trailing: 2
            ) -
            EdgeInsets_LeadingTrailing(
                leading: 3,
                trailing: 4
            )
        
        XCTAssertEqual(insets.leading, -2)
        XCTAssertEqual(insets.trailing, -2)
    }
    
    func testSubtractionAssignment() {
        var insets: EdgeInsets_LeadingTrailing = .init(
            leading: 1,
            trailing: 2
        )
        insets -= EdgeInsets_LeadingTrailing(
            leading: 3,
            trailing: 4
        )
        
        XCTAssertEqual(insets.leading, -2)
        XCTAssertEqual(insets.trailing, -2)
    }
}
