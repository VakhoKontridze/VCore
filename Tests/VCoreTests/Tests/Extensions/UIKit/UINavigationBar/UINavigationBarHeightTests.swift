//
//  UINavigationBarHeightTests.swift
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
final class UINavigationBarHeightTests: XCTestCase {
    func test() {
        let height: CGFloat = UINavigationBar.height

        XCTAssertGreaterThan(height, 0)
    }
}

#endif
