//
//  NSColorRGBAValuesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct NSColorRGBAValuesTests {
    @Test
    func testValues() {
        #expect(
            NSColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4).rgbaValues ==
            (0.1, 0.2, 0.3, 0.4)
        )
    }
    
    @Test
    func testComponents() {
        #expect(
            NSColor(red: 10.0/255, green: 20.0/255, blue: 30.0/255, alpha: 0.5).rgbaComponents ==
            (10, 20, 30, 0.5)
        )
    }
    
    @Test
    func testISRGBAEqual() {
        #expect(NSColor.red.isRGBAEqual(to: .red))
        #expect(!NSColor.red.isRGBAEqual(to: .blue))
    }
}

#endif
