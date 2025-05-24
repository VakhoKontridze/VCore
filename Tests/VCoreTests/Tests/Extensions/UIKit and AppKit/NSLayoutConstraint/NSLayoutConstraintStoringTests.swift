//
//  NSLayoutConstraintStoringTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
@MainActor
struct NSLayoutConstraintStoringTests {
    @Test
    func test() {
        let view: UIView = .init()
        
        var constraint: NSLayoutConstraint?
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100)
                .storing(in: &constraint)
        ])
        
        #expect(constraint?.constant == 100)
    }
}

#endif
