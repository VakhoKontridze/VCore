//
//  NSColorLightenAndDarkenTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import Testing
@testable import VCore

@Suite
nonisolated struct NSColorLightenAndDarkenTests {
    @Test
    func testLightened() {
        #expect(
            NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).lightened(by: 0.1) ==
            NSColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        )
    }

    @Test
    func testDarkened() {
        #expect(
            NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).darkened(by: 0.1) ==
            NSColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        )
    }
}

#endif
