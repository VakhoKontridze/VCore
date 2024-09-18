//
//  NSLayoutConstraintStoringTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
@MainActor
final class NSLayoutConstraintStoringTests: XCTestCase {
    func test() {
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint?
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .storing(in: &constraint)
        ])
        
        XCTAssertEqual(constraint?.constant, 100)
    }
}

#endif
