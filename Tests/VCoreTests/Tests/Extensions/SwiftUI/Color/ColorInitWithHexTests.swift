//
//  ColorInitWithHexTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 20.05.23.
//

// Other test cases are covered under `UIColorInitWithHexTests`

import SwiftUI
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ColorInitWithHexTests {
    @Test
    func test() {
        #expect(
            Color(hex: "#007AFF") ==
            Color(red: 0/255, green: 122/255, blue: 255/255)
        )
    }
}
