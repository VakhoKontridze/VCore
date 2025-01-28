//
//  RangeReversedArrayOnConditionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 25.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct RangeReversedArrayOnConditionTests {
    @Test
    func test() {
        #expect((1..<4).reversedArray(false) == [1, 2, 3])
        #expect((1..<4).reversedArray(true) == [3, 2, 1])
        #expect((1..<4).reversedArray() == [3, 2, 1])
    }
}
