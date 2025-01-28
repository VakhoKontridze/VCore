//
//  RangeInitWithBoundsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 02.07.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct RangeInitWithBoundsTests {
    @Test
    func test() {
        #expect(Range(lower: 1, upper: 10) == 1..<10)
    }
}
