//
//  UIStackViewConfigurationTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIStackViewConfigurationTests: XCTestCase {
    // MARK: Test Data
    private let axis: NSLayoutConstraint.Axis = .vertical
    private let distribution: UIStackView.Distribution = .equalSpacing
    private let alignment: UIStackView.Alignment = .leading
    private let spacing: CGFloat = 10
    
    // MARK: Test
    func testConfiguration() {
        let stackView: UIStackView = .init()
        
        stackView.configure(
            axis: axis,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing
        )
        
        XCTAssertEqual(stackView.axis, axis)
        XCTAssertEqual(stackView.distribution, distribution)
        XCTAssertEqual(stackView.alignment, alignment)
        XCTAssertEqual(stackView.spacing, spacing)
    }
    
    func testInit() {
        let stackView: UIStackView = .init(
            axis: axis,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing
        )
        
        XCTAssertEqual(stackView.axis, axis)
        XCTAssertEqual(stackView.distribution, distribution)
        XCTAssertEqual(stackView.alignment, alignment)
        XCTAssertEqual(stackView.spacing, spacing)
    }
}

#endif
