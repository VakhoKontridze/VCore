//
//  CGRectToNSLayoutConstraintsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class CGRectToNSLayoutConstraintsTests: XCTestCase {
    // MARK: Test Data
    private let superview: UIView = .init(frame: CGRect(
        origin: .zero,
        size: CGSize(width: 300, height: 400)
    ))
    
    private let viewRect: CGRect = .init(
        origin: CGPoint(x: 100, y: 100),
        size: CGSize(width: 150, height: 200)
    )
    
    // MARK: Tests
    func testLeadingConstraint() {
        XCTAssertEqual(
            viewRect.leadingConstraintConstant,
            100
        )
    }
    
    func testTrailingConstraint() {
        XCTAssertEqual(
            viewRect.trailingConstraintConstant(in: superview.frame.width),
            50
        )
    }
    
    func testTopConstraint() {
        XCTAssertEqual(
            viewRect.topConstraintConstant,
            100
        )
    }
    
    func testBottomConstraint() {
        XCTAssertEqual(
            viewRect.bottomConstraintConstant(in: superview.frame.height),
            100
        )
    }
    
    func testCenter() {
        XCTAssertEqual(
            viewRect.center,
            CGPoint(x: 175, y: 200)
        )
    }
    
    func testCenterX() {
        XCTAssertEqual(
            viewRect.centerX,
            175
        )
    }
    
    func testCenterY() {
        XCTAssertEqual(
            viewRect.centerY,
            200
        )
    }
}

#endif
