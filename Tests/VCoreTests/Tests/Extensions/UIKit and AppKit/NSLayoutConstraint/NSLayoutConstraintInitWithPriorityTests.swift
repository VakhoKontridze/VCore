//
//  NSLayoutConstraintInitWithPriorityTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
@MainActor
struct NSLayoutConstraintInitWithPriorityTests {
    @Test
    func test() {
        let view1: UIView = .init()
        let view2: UIView = .init()
        
        let constraint: NSLayoutConstraint = .init(
            item: view1,
            attribute: .width,
            relatedBy: .equal,
            toItem: view2,
            attribute: .width,
            multiplier: 1,
            constant: 0,
            priority: .required
        )
        
        #expect(constraint.priority == .required)
    }
}

#endif
