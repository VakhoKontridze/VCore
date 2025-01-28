//
//  UIColorInitWithHexTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

#if canImport(UIKit)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
final class UIColorInitWithHexTests {
    @Test
    func testString() throws {
        #expect(
            UIColor(hex: "#007AFF") ==
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )

        #expect(
            UIColor(hex: "#000000007AFF") == // +0(6)
            nil
        )

        #expect(
            UIColor(hex: "007AFF") ==
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }

    @Test
    func testUInt() throws {
        #expect(
            UIColor(hex: 0x007AFF) ==
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )

        #expect(
            UIColor(hex: 0x000000007AFF) == // +0(6)
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        )
    }
}

#endif
