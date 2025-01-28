//
//  NSLayoutConstraintWithPriorityTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@MainActor
@Suite
struct NSLayoutConstraintWithPriorityTests {
    @Test
    func testLayoutPriority() {
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint?
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .withPriority(.required)
                .storing(in: &constraint)
        ])
        
        #expect(constraint?.priority == .required)
    }
    
    @Test
    func testConstant() {
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint?
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .withPriority(500)
                .storing(in: &constraint)
        ])
        
        #expect(
            (constraint?.priority.rawValue).map { CGFloat($0) } ==
            500
        )
    }
}

#endif

