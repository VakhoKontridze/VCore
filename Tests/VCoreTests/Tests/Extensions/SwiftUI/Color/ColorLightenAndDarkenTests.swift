//
//  ColorLightenAndDarkenTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import SwiftUI
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ColorLightenAndDarkenTests {
    @Test
    func testLighten() {
        let color: Color = .init(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)

        let values = color.lighten(by: 0.1).rgbaValues

        // Direct comparison gives floating-point issues, so equality with tolerance must be used
        #expect(values.red == 0.6)
        #expect(values.green == 0.6)
        #expect(values.blue == 0.6)
        #expect(areEqual(values.alpha, 1, tolerance: pow(10, -5)))
    }

    @Test
    func testDarken() {
        let color: Color = .init(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)

        let values = color.darken(by: 0.1).rgbaValues

        // Direct comparison gives floating-point issues, so equality with tolerance must be used
        #expect(values.red == 0.4)
        #expect(values.green == 0.4)
        #expect(values.blue == 0.4)
        #expect(areEqual(values.alpha, 1, tolerance: pow(10, -5)))
    }
}
