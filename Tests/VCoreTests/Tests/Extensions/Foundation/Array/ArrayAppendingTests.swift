//
//  ArrayAppendingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayAppendingTests {
    @Test
    func testAppendingElement() {
        #expect(
            [1, 2].appending(3) ==
            [1, 2, 3]
        )
    }

    @Test
    func testAppendingElements() {
        #expect(
            [1, 2].appending(contentsOf: [3, 4]) ==
            [1, 2, 3, 4]
        )
    }
}
