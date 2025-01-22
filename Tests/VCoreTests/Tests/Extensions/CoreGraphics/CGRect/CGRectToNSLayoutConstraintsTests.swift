//
//  CGRectToNSLayoutConstraintsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS) // `UIView` doesn't exist on watchOS

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
@MainActor
struct CGRectToNSLayoutConstraintsTests {
    // MARK: Test Data
    private let superview: UIView = .init(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: 300, height: 400)
        )
    )

    private let viewRect: CGRect = .init(
        origin: CGPoint(x: 100, y: 100),
        size: CGSize(width: 150, height: 200)
    )
    
    // MARK: Tests
    @Test
    func testLeftConstraint() {
        #expect(
            viewRect.leftConstraintConstant ==
            100
        )
    }
    
    @Test
    func testRightConstraint() {
        #expect(
            viewRect.rightConstraintConstant(in: superview.frame.width) ==
            50
        )
    }
    
    @Test
    func testTopConstraint() {
        #expect(
            viewRect.topConstraintConstant ==
            100
        )
    }
    
    @Test
    func testBottomConstraint() {
        #expect(
            viewRect.bottomConstraintConstant(in: superview.frame.height) ==
            100
        )
    }
    
    @Test
    func testCenter() {
        #expect(
            viewRect.center ==
            CGPoint(x: 175, y: 200)
        )
    }
    
    @Test
    func testCenterX() {
        #expect(
            viewRect.centerX ==
            175
        )
    }
    
    @Test
    func testCenterY() {
        #expect(
            viewRect.centerY ==
            200
        )
    }
}

#endif
