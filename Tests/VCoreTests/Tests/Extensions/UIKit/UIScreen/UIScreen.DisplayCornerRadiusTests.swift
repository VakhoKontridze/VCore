//
//  UIScreenDisplayCornerRadiusTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIScreenDisplayCornerRadiusTests: XCTestCase {
    func test() {
        // If nil is returned, API was deprecated. In case of non-rounded devices, `0` is returned.
        guard let displayCornerRadius: CGFloat = UIScreen.main.displayCornerRadius else { return }
        
        XCTAssertGreaterThanOrEqual(displayCornerRadius, 0)
    }
}

#endif
