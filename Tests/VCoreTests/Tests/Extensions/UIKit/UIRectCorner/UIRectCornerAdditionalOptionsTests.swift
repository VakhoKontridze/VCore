//
//  UIRectCornerAdditionalOptionsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.06.22.
//

#if canImport(UIKit)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class UIRectCornerAdditionalOptionsTests: XCTestCase {
    func test() {
        // `rawValue` of `allCorners` is `18446744073709551615`
        let allCornersRawValue: UInt = UIRectCorner([.topLeft, .topRight, .bottomRight, .bottomLeft]).rawValue
        
        XCTAssertEqual(UIRectCorner.leftCorners.union(.rightCorners).rawValue, allCornersRawValue)
        XCTAssertEqual(UIRectCorner.topCorners.union(.bottomCorners).rawValue, allCornersRawValue)
    }
}

#endif
