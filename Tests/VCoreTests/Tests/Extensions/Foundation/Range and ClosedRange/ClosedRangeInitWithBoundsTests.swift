//
//  ClosedRangeInitWithBoundsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.08.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ClosedRangeInitWithBoundsTests {
    @Test
    func test() {
        #expect(
            ClosedRange(lower: 1, upper: 10) ==
            1...10
        )
    }
}
