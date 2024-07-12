//
//  NSLayoutConstraintWithPriorityTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class NSLayoutConstraintWithPriorityTests: XCTestCase {
    func testLayoutPriority() {
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint?
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .withPriority(.required)
                .storing(in: &constraint)
        ])
        
        XCTAssertEqual(constraint?.priority, UILayoutPriority.required)
    }
    
    func testConstant() {
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint?
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .withPriority(500)
                .storing(in: &constraint)
        ])
        
        XCTAssertEqual(
            (constraint?.priority.rawValue).map { CGFloat($0) },
            500
        )
    }
}

#endif

