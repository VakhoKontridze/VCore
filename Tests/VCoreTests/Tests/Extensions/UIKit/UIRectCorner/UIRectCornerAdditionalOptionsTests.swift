//
//  UIRectCornerAdditionalOptionsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.06.22.
//

#if canImport(UIKit)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct UIRectCornerAdditionalOptionsTests {
    @Test
    func test() {
        // `rawValue` of `allCorners` is `18446744073709551615`
        let allCornersRawValue: UInt = UIRectCorner([.topLeft, .topRight, .bottomRight, .bottomLeft]).rawValue
        
        #expect(UIRectCorner.leftCorners.union(.rightCorners).rawValue == allCornersRawValue)
        #expect(UIRectCorner.topCorners.union(.bottomCorners).rawValue == allCornersRawValue)
    }
}

#endif
