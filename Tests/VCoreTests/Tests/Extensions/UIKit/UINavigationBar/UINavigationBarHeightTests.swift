//
//  UINavigationBarHeightTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@MainActor
@Suite
struct UINavigationBarHeightTests {
    @Test
    func test() {
        #expect(UINavigationBar.height > 0)
    }
}

#endif
