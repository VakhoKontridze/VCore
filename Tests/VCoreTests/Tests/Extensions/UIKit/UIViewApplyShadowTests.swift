//
//  UIViewApplyShadowTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIViewApplyShadowTests: XCTestCase {
    private let cornerRadius: CGFloat = 10
    private let color: UIColor = .black
    private let radius: CGFloat = 5
    private let offset: CGSize = .init(width: 0, height: 5)
    
    func testShadow() {
        let view: UIView = .init()

        view.applyShadow(
            color: color,
            radius: radius,
            offset: offset
        )

        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
        XCTAssertEqual(view.layer.shadowOpacity, 1)
        XCTAssertEqual(view.layer.shadowRadius, radius)
        XCTAssertEqual(view.layer.shadowOffset, offset)
    }
    
    func roundCornersAndApplyShadow() {
        let view: UIView = .init()

        view.roundCornersAndApplyShadow(
            cornerRadius: cornerRadius,
            color: color,
            radius: radius,
            offset: offset
        )

        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
        XCTAssertEqual(view.layer.shadowOpacity, 1)
        XCTAssertEqual(view.layer.shadowRadius, radius)
        XCTAssertEqual(view.layer.shadowOffset, offset)
    }
}

#endif
