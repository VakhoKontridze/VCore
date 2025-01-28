//
//  ArrayPrependingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.07.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayPrependingTests {
    @Test
    func testPrependingElement() {
        #expect(
            [2, 3].prepending(1) ==
            [1, 2, 3]
        )
    }

    @Test
    func testPrependingElements() {
        #expect(
            [3, 4].prepending(contentsOf: [1, 2]) ==
            [1, 2, 3, 4]
        )
    }
}
