//
//  NumericNonZeroTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 26.11.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct NumericNonZeroTests {
    @Test
    func test() {
        #expect(0.nonZero == nil)
        #expect(1.nonZero == 1)
    }
}
