//
//  ClosedRangeReversedArrayOnConditionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ClosedRangeReversedArrayOnConditionTests {
    @Test
    func test() {
        #expect((1...3).reversedArray(false) == [1, 2, 3])
        #expect((1...3).reversedArray(true) == [3, 2, 1])
        #expect((1...3).reversedArray() == [3, 2, 1])
    }
}
