//
//  NSLayoutConstraintWithPriorityTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class NSLayoutConstraintWithPriorityTests: XCTestCase {
    func testLayoutPriority() {
        let priority: UILayoutPriority = .required
        
        let view: UIView = .init()

        var constraint: NSLayoutConstraint? = nil
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .withPriority(priority)
                .storing(in: &constraint)
        ])
        
        XCTAssertEqual(constraint?.priority, priority)
    }
    
    func testPriorityConstant() {
        let priority: CGFloat = 100
        
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint? = nil
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .withPriority(priority)
                .storing(in: &constraint)
        ])
        
        XCTAssertEqual(
            (constraint?.priority.rawValue).map { CGFloat($0) },
            priority
        )
    }
}

#endif

