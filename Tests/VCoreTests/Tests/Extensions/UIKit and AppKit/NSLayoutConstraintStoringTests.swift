//
//  NSLayoutConstraintStoringTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class NSLayoutConstraintStoringTests: XCTestCase {
    func test() {
        let width: CGFloat = 100
        
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint? = nil
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width)
                .storing(in: &constraint)
        ])
        
        XCTAssertEqual(constraint?.constant, width)
    }
}

#endif
