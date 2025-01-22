//
//  UIColorLightenAndDarkenTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct UIColorLightenAndDarkenTests {
    @Test
    func testLighten() {
        #expect(
            UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).lighten(by: 0.1) ==
            UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        )
    }

    @Test
    func testDarken() {
        #expect(
            UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).darken(by: 0.1) ==
            UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        )
    }
}

#endif
