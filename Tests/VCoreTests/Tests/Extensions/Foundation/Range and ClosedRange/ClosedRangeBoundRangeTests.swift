//
//  ClosedRangeBoundRangeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 05.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ClosedRangeBoundRangeTests {
    @Test
    func test() {
        #expect((3...10).boundRange == 7)
    }
}
