//
//  NSLayoutConstraintInitWithPriorityTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class NSLayoutConstraintInitWithPriorityTests: XCTestCase {
    func test() {
        let view1: UIView = .init()
        let view2: UIView = .init()
        
        let priority: UILayoutPriority = .required
        
        let constraint: NSLayoutConstraint = .init(
            item: view1,
            attribute: .width,
            relatedBy: .equal,
            toItem: view2,
            attribute: .width,
            multiplier: 1,
            constant: 0,
            priority: priority
        )
        
        XCTAssertEqual(constraint.priority, priority)
    }
}

#endif
