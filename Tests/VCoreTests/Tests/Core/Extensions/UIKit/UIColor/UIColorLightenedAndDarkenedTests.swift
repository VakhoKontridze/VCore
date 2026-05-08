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

@Suite
nonisolated struct UIColorLightenAndDarkenTests {
    @Test
    func testLightened() {
        #expect(
            UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).lightened(by: 0.1) ==
            UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        )
    }

    @Test
    func testDarkened() {
        #expect(
            UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).darkened(by: 0.1) ==
            UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        )
    }
}

#endif
