//
//  UIStackViewConfigureTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
@MainActor
final class UIStackViewConfigureTests: XCTestCase {
    func testConfigure() {
        let stackView: UIStackView = .init()
        
        stackView.configure(
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .leading,
            spacing: 10
        )
        
        XCTAssertEqual(stackView.axis, NSLayoutConstraint.Axis.vertical)
        XCTAssertEqual(stackView.distribution, UIStackView.Distribution.equalSpacing)
        XCTAssertEqual(stackView.alignment, UIStackView.Alignment.leading)
        XCTAssertEqual(stackView.spacing, 10)
    }
    
    func testInit() {
        let stackView: UIStackView = .init(
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .leading,
            spacing: 10
        )
        
        XCTAssertEqual(stackView.axis, NSLayoutConstraint.Axis.vertical)
        XCTAssertEqual(stackView.distribution, UIStackView.Distribution.equalSpacing)
        XCTAssertEqual(stackView.alignment, UIStackView.Alignment.leading)
        XCTAssertEqual(stackView.spacing, 10)
    }
}

#endif
