//
//  UIViewApplyShadowTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class UIViewApplyShadowTests: XCTestCase {
    func testShadow() {
        let view: UIView = .init()
        
        view.applyShadow(
            color: UIColor.black,
            radius: 5,
            offset: CGSize(width: 0, height: 5)
        )
        
        XCTAssertEqual(view.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(view.layer.shadowOpacity, 1)
        XCTAssertEqual(view.layer.shadowRadius, 5)
        XCTAssertEqual(view.layer.shadowOffset, CGSize(width: 0, height: 5))
    }
    
    func testRoundCornersAndApplyShadow() {
        let view: UIView = .init()
        
        view.roundCornersAndApplyShadow(
            cornerRadius: 10,
            color: UIColor.black,
            radius: 5,
            offset: CGSize(width: 0, height: 5)
        )
        
        XCTAssertEqual(view.layer.cornerRadius, 10)
        XCTAssertEqual(view.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(view.layer.shadowOpacity, 1)
        XCTAssertEqual(view.layer.shadowRadius, 5)
        XCTAssertEqual(view.layer.shadowOffset, CGSize(width: 0, height: 5))
    }
}

#endif
